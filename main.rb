require_relative 'lib/card'
require_relative 'lib/desk/desk52'
require_relative 'lib/rules_blackjack'
require_relative 'lib/party'
require_relative 'lib/bank'

include RulesBlackjack

deck = Deck52.new
money = 100
bank = Bank.new

puts 'Play Blackjack'
print 'Enter your name: '
player_name = gets.chomp
player = Party.new(player_name, money)
dealer = Party.new('Casino', money)

loop do
  if player.amount < 10
    puts 'You have insufficient funds to bet.'
    break
  end
  if dealer.amount < 10
    puts 'At the casino is not enough money.'
    break
  end

  deck.shuffle!
  bank.push(player.bet(10))
  bank.push(dealer.bet(10))

  player.hand(deck.pop)
  player.hand(deck.pop)
  dealer.hand(deck.pop)
  dealer.hand(deck.pop)

  loop do
    puts "You have on the cards: #{player.show_cards}, points: #{player.points}"
    puts "Casino have on the cards: #{dealer.show_hidden_cards}"
    puts <<-MENU

Action choice
1 - skip
2 - add
3 - open
    MENU
    choice = gets.strip
    break if choice == '3'
    player.hand(deck.pop) if choice == '2'

    break if dealer.points == 21
    dealer.hand(deck.pop) if dealer.points < 17

    break if player.number_cards >= 3 && dealer.number_cards >= 3
  end

  puts "You have cards: #{player.show_cards}, points: #{player.points}"
  puts "Casino have cards: #{dealer.show_cards}, points: #{dealer.points}"

  compare = RulesBlackjack.comparison_points(player.points, dealer.points)
  case compare
  when 1
    puts 'You won!'
    player.win(bank.pop_full!)
  when -1
    puts 'Casino won.'
    dealer.win(bank.pop_full!)
  when 0
    puts 'draw'
    win = bank.pop_full! / 2
    player.win(win)
    dealer.win(win)
  end
  puts "You have in the bank #{player.amount} rubles."
  puts "The dealer at the bank #{dealer.amount} rubles."

  deck.push(player.throw_all_cards)
  deck.push(dealer.throw_all_cards)

  puts <<-MENU

Action choice
any - continue the game
0 - end the game
  MENU
  choice = gets.strip

  break if choice == '0'
end
