(1..20).each do |i|
  multiple3 = i % 3 == 0
  multiple5 = i % 5 == 0
  if multiple3 && multiple5
    puts 'FizzBuzz'
  elsif multiple3
    puts 'Fizz'
  elsif multiple5
    puts 'Buzz'
  else
    puts i
  end
end
