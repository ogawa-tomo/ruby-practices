# frozen_string_literal: true

(1..20).each do |i|
  multiple3 = (i % 3).zero?
  multiple5 = (i % 5).zero?
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
