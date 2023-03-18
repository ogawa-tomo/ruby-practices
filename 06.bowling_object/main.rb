#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

data = ARGV[0].split(',')

frame_num = 1
pointer = 0
frames = []
loop do
  break if data[pointer].nil?

  if data[pointer] == 'X'
    frames << Frame.new(10, 0, frame_num)
    pointer += 1
  else
    first_shot = data[pointer].to_i
    second_shot = data[pointer + 1].to_i || 0
    frames << Frame.new(first_shot, second_shot, frame_num)
    pointer += 2
  end
  frame_num += 1
end

score = 0
frames.each_with_index do |frame, i|
  score += frame.get_score(frames[i + 1], frames[i + 2])
end

puts score
