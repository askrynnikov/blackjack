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
  end

  def take_card
    raise 'the deck has no cards' if @cards.size.zero?
    @cards.pop
  end

  def put_card(card)
    @cards << card
  end
end


deck = Deck52.new
deck.shuffle!

53.times{puts deck.take_card.symbol}
# puts deck.take_card.symbol
# puts deck.take_card.symbol
