#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

def main
  data = ARGV[0].split(',')
  frames = make_frames(data)
  game_score = calc_score(frames)
  puts game_score
end

def make_frames(data)
  frame_num = 1
  pointer = 0
  frames = []
  loop do

    if frame_num == 10
      frames << Frame.new(
        Shot.new(data[pointer]),
        Shot.new(data[pointer + 1]),
        Shot.new(data[pointer + 2])
      )
      break
    end

    shot = Shot.new(data[pointer])

    if shot.strike?
      frames << Frame.new(shot, Shot.new(nil), Shot.new(nil))
      pointer += 1
    else
      second_shot = Shot.new(data[pointer + 1])
      frames << Frame.new(shot, second_shot, Shot.new(nil))
      pointer += 2
    end
    frame_num += 1
  end
  return frames
end

def calc_score(frames)
  score = 0
  frames.each_with_index do |frame, frame_num|

    score += frame.total_score
    break if frame_num == 9
    
    if frame.strike?
      score += frames[frame_num + 1].first_and_second_shot_score
      score += frames[frame_num + 2].first_shot_score if frames[frame_num + 1].strike?
    elsif frame.spare?
      score += frames[frame_num + 1].first_shot_score
    end
  end
  return score
end

main
