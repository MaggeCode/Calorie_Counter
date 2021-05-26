DISHES_CALORIES = {
  "Hamburger" => 250,
  "Cheese Burger" => 300,
  "Big Mac" => 540,
  "McChicken" => 350,
  "French Fries" => 230,
  "Salad" => 15,
  "Coca Cola" => 150,
  "Sprite" => 150
}

def total_calories(burger, side, drink)
  DISHES_CALORIES[burger] + DISHES_CALORIES[side] + DISHES_CALORIES[drink]
end

puts "Which item do you want to buy?"
 DISHES_CALORIES.each do |key, value|
  puts "#{key} with calories: #{value}"
end 

puts "Select burger:"
burger = gets.chomp 
puts "#{burger} selected"

puts "What about a side? French Fries or Salad"
side = gets.chomp 
puts "#{side} selected" 

puts "Now a drink?"
drink = gets.chomp 
puts "#{drink} selected"

puts "Total calorie count is:"
puts total_calories(burger, side, drink)

puts "For survey purposes: What is your age?"
age = gets.chomp.to_i 

puts "What about gender?"
gender = gets.chomp

puts "We are now running some very complicated analytics that will provide insights regarding your calorie intake..."
