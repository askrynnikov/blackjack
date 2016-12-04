# game bank
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
