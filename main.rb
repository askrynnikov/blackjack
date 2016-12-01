PIPS = { ace: 'A', two: '2', three: '3', four: '4', five: '5',
         six: '6', seven: '7', eight: '8', nine: '9', ten: '10',
         jack: 'J', queen: 'Q', king: 'K' }

SUITS = { spades: "\u2660",
          hearts: "\u2665",
          diamonds: "\u2666",
          clubs: "\u2663" }

class Card
  attr_reader :name, :pip, :suit, :symbol

  def initialize(name, pip, suit, symbol)
    @name = name
    @pip = pip
    @suit = suit
    @symbol = symbol
  end

  def to_s
    symbol
  end
end

class Deck
  def initialize
    @cards = []
  end
end

class Deck52 < Deck
  def initialize
    super
    SUITS.each do |suit, suit_symbol|
      PIPS.each do |pip, pip_symbol|
        card_name = "#{pip} of #{suit}"
        card_symbol = "#{pip_symbol}#{suit_symbol}"
        @cards << Card.new(card_name, pip, suit, card_symbol)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
    self
  end

  def pop
    raise 'the deck has no cards' if @cards.size.zero?
    @cards.pop
  end

  def push(card)
    if card.is_a?(Array)
      @cards += card
    else
      @cards << card
    end
    self
  end
end

class Bank
  attr_reader :amount

  def initialize(amount = 0)
    @amount = amount
  end

  def push(amount)
    @amount += amount
    self
  end

  def pop(amount)
    raise 'bank contains less than the requested amount' if amount > @amount
    @amount -= amount
    self
  end

  def pop_full!
    amount = @amount
    @amount = 0
    amount
  end

end

module RulesBlackjack
  POINTS = { ace: 1, two: 2, three: 3, four: 4, five: 5,
             six: 6, seven: 7, eight: 8, nine: 9, ten: 10,
             jack: 10, queen: 10, king: 10 }

  def points_count(*cards)
    points = cards.reduce(0) { |p, card| p + POINTS[card.pip] }
    cards.reduce(points) do |p, card|
      p + (card.pip == :ace && p <= 11 ? 10 : 0)
    end
  end

  def comparison_points(p1, p2)
    if p1 <= 21 && (p2 < p1 || p2 > 21)
      1
    elsif p2 <= 21 && (p1 < p2 || p1 > 21)
      -1
    else
      0
    end
  end

end

class Party
  include RulesBlackjack

  attr_reader :amount

  def initialize(amount = 0)
    @amount = amount
    @cards = []
  end

  def points
    points_count(*@cards)
  end

  def bet(amount)
    raise 'member has no such amount' if amount > @amount
    @amount -= amount
    amount
  end

  def win(amount)
    @amount += amount
    self
  end

  def hand(card)
    @cards << card
    self
  end

  def throw_all_cards
    cards = @cards.dup
    @cards = []
    return cards
  end
end


include RulesBlackjack

# 52.times { puts deck.pop.symbol }
# puts deck.take_card.symbol
# puts deck.take_card.symbol

# puts RulesBlackjack::points_count(deck.pop, deck.pop)

player = Party.new(100)
dealer = Party.new(100)
bank = Bank.new()
deck = Deck52.new


100.times do |i|
  deck.shuffle!

  bank.push(player.bet(10))
  bank.push(dealer.bet(10))

  player.hand(deck.pop)
  player.hand(deck.pop)
  dealer.hand(deck.pop)
  dealer.hand(deck.pop)

  player.hand(deck.pop) if player.points < 17
  dealer.hand(deck.pop) if dealer.points < 17

  puts player.points
  puts dealer.points

  compare = RulesBlackjack.comparison_points(player.points, dealer.points)
  case compare
  when 1
    player.win(bank.pop_full!)
  when -1
    dealer.win(bank.pop_full!)
  when 0
    win = bank.pop_full! / 2
    player.win(win)
    dealer.win(win)
  end


  puts i
  puts player.amount
  puts dealer.amount

  deck.push(player.throw_all_cards)
  deck.push(dealer.throw_all_cards)
end

# if player.points <=21