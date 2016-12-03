require_relative '../deck.rb'

# deck of 52 cards
class Deck52 < Deck
  def initialize
    super
    SUITS.each do |suit, suit_symbol|
      PIPS.each do |pip, pip_symbol|
        card_name = "#{pip} of #{suit}"
        card_symbol = "#{pip_symbol}#{suit_symbol}"
        push(Card.new(card_name, pip, suit, card_symbol))
      end
    end
  end
end
