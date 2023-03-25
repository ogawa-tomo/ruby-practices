# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(mark_data)
    @frames = make_frames(mark_data)
  end

  def calc_score
    score = 0
    @frames.each_with_index do |frame, i|
      frame_num = i + 1

      score += frame.total_score
      break if frame_num == 10

      next_frame = @frames[i + 1]
      frame_after_next = @frames[i + 2]

      if frame.strike?
        score += next_frame.first_and_second_shot_score
        score += frame_after_next.first_shot_score if next_frame.strike? && frame_num <= 8
      elsif frame.spare?
        score += next_frame.first_shot_score
      end
    end
    score
  end

  private

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
    frames
  end
end
