# card deck
class Deck
  PIPS = { ace: 'A', two: '2', three: '3', four: '4', five: '5',
           six: '6', seven: '7', eight: '8', nine: '9', ten: '10',
           jack: 'J', queen: 'Q', king: 'K' }.freeze

  SUITS = { spades: "\u2660",
            hearts: "\u2665",
            diamonds: "\u2666",
            clubs: "\u2663" }.freeze

  def initialize
    @cards = []
  end

  def shuffle!
    @cards.shuffle!
    self
  end

  def pop
    raise 'the deck has no cards' if cards.size.zero?
    cards.pop
  end

  def push(card)
    cards.push(*card)
    self
  end

  protected

  attr_accessor :cards
end
