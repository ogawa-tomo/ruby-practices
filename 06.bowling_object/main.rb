#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end
shots << 0 if shots.length.odd?

frames = []
shots.each_slice(2).each_with_index do |s, i|
  frames << Frame.new(s[0], s[1], i)
end

point = 0
frames.each_with_index do |frame, i|
  point += frame.get_point(frames[i + 1], frames[i + 2])
end

puts point
