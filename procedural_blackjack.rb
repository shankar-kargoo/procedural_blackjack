# 'procedural blackjack'

require 'pry'

# game set up 
puts ""
puts "Welcome to Blackjack"
puts ""
puts "What is your name?"
player = gets.chomp
puts ""
puts "Lets start the game, shuffling and dealing cards..."
puts ""
sleep 1

suites = ['H', 'S', 'D', 'C']
numbers = [ '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suites.product(numbers)
deck.shuffle!

#deal cards
player_cards = []
dealer_cards = []

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

puts "dealer cards are #{dealer_cards}"
puts "#{player} your cards are #{player_cards}"

def calculate_total(array)
  sum = 0
  y = array.map { |x| x.last }

  y.each do |b|
    if b == 'A'
      sum += 11
    elsif b.to_i == 0
      sum += 10 
    else
      sum += b.to_i    
    end
  end

  # correction for A
  y.select{|e| e == 'A' }.count.times do
    sum -=10 if sum > 21
  end

  return sum
end

dealer_total = calculate_total(dealer_cards)
player_total = calculate_total(player_cards)

puts "dealer_total = #{calculate_total(dealer_cards)}"
puts "#{player} your total = #{calculate_total(player_cards)}"

# check if draw
if player_total == 21 && dealer_total == 21
  puts "You both hit blackjack, It's a draw"
  exit
end

# player plays
if player_total == 21
  puts "Contratulations you hit BlackJack, you win"
  exit
end

while player_total < 21 do
  
  puts "Your turn, Enter 1 to Hit, 2 to Stay"
  user_selection = gets.chomp
  
  if user_selection != '1' && user_selection != '2'
     puts "Please enter a valid input"
    redo
  end

  if user_selection == "2"
    puts "You choose to stay, Next the dealers turn"
    break
  end
  
  if user_selection == "1"
    new_card = deck.pop
    puts "new card dealt is #{new_card}"
    player_cards << new_card    
    puts "#{player} your cards are #{player_cards}"
    player_total = calculate_total(player_cards)
    puts "#{player} your total = #{player_total}"

      if player_total == 21
        puts "Vola, you hit blackjack, you win!"
        exit
      elsif player_total > 21
        puts "Oh no, your total is #{player_total}, you are busted!"
        exit
      else
        next
      end
  end
end

# dealer plays

if dealer_total == 21
  puts "Dealer hits blackjack. #{player} you lost!"
  exit
end

while dealer_total < 17 do
  new_card = deck.pop
  puts "Dealer has a new card: #{new_card}"
  dealer_cards << new_card    
  puts "dealer cards are #{dealer_cards}"
  dealer_total = calculate_total(dealer_cards)
  puts "Dealer total = #{dealer_total}"
    if dealer_total >  21
      puts "The dealer went bust, #{player} you won!"
      exit
    elsif dealer_total == 21
      puts "The dealer hit blackjack, #{player} you lost!"
    elsif dealer_total < 17
      puts "Dealer hitting next card"
      next
    end
end

  
if dealer_total == player_total
  puts "It's a draw!"
  exit
elsif dealer_total > player_total
  puts "the dealer has a better hand, the dealer won!"
  exit
else
  puts "#{player}, you have a better hand. You Won!"
  exit
end