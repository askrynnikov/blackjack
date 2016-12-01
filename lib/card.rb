# playing card
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
