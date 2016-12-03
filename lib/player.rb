require_relative 'rules_blackjack'

# party games
class Player
  include RulesBlackjack

  attr_reader :name, :amount

  def initialize(name, amount = 0)
    @name = name
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
    cards
  end

  def to_s
    "#{name} #{amount}rub."
  end

  def number_cards
    @cards.size
  end

  def show_cards
    @cards.reduce('') { |acc, elem| acc + ' ' + elem.symbol }.strip
  end

  def show_hidden_cards
    @cards.reduce('') { |acc, _elem| acc + ' **' }.strip
  end
end
