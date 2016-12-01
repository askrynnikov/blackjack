require_relative '../deck'

# deck of 52 cards
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
