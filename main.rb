SUITS = { spades: "\u2660",
          hearts: "\u2665",
          diamonds: "\u2666",
          clubs: "\u2663" }
PIPS = { ace: 'A', two: '2', three: '3', four: '4', five: '5',
         six: '6', seven: '7', eight: '8', nine: '9', ten: '10',
         jack: 'J', queen: 'Q', king: 'K' }

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
    @cards << card
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

  def pop_full
    amount = @amount.dup
    @amount = 0
    amount
  end
end

class Blackjack
  POINTS = { ace: 1, two: 2, three: 3, four: 4, five: 5,
             six: 6, seven: 7, eight: 8, nine: 9, ten: 10,
             jack: 10, queen: 10, king: 10 }

  def points_count(*cards)
    points = cards.reduce(0) { |p, card| p + POINTS[card.pip] }
    cards.reduce(points) do |p, card|
      p + (card.pip == :ace && p <= 11 ? 10 : 0)
    end
  end
end

class Party
  def initialize(amount = 0)
    @amount = amount
  end

  def bet(amount)
    raise 'member has no such amount' if amount > @amount
    @amount -= amount
    amount
  end
end

deck = Deck52.new
deck.shuffle!

# 52.times { puts deck.pop.symbol }
# puts deck.take_card.symbol
# puts deck.take_card.symbol

puts Blackjack.new.points_count(deck.pop, deck.pop)