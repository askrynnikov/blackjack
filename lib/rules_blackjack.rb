# rules of the game Blackjack
module RulesBlackjack
  POINTS = { ace: 1, two: 2, three: 3, four: 4, five: 5,
             six: 6, seven: 7, eight: 8, nine: 9, ten: 10,
             jack: 10, queen: 10, king: 10 }.freeze

  def points_count(*cards)
    points = cards.reduce(0) { |acc, elem| acc + POINTS[elem.pip] }
    cards.reduce(points) do |acc, elem|
      acc + (elem.pip == :ace && acc <= 11 ? 10 : 0)
    end
  end

  def comparison_points(p1, p2)
    if p1 == p2 || (p1 > 21 && p2 > 21)
      0
    elsif p2 > 21 || (p1 <= 21 && p1 > p2)
      1
    else
      -1
    end
  end
end
