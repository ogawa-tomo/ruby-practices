#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

data = ARGV[0].split(',')

frame_num = 1
pointer = 0
frames = []
loop do
  break if data[pointer].nil?

  shot = Shot.new(data[pointer])

  if shot.strike?
    frames << Frame.new(shot, Shot.new(0), frame_num)
    pointer += 1
  else
    second_shot = Shot.new(data[pointer + 1])
    frames << Frame.new(shot, second_shot, frame_num)
    pointer += 2
  end
  frame_num += 1
end

score = 0
frames.each_with_index do |frame, i|
  score += frame.get_score(frames[i + 1], frames[i + 2])
end

puts score
