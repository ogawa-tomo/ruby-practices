# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(marks)
    @frames = make_frames(marks)
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

  def make_frames(marks)
    pointer = 0
    frames = []
    shots = marks.map { |mark| Shot.new(mark) }

    (1..10).each do |frame_num|
      if frame_num == 10
        frames << Frame.new(shots[pointer], shots[pointer + 1], shots[pointer + 2] || Shot.new(nil))
        break
      end

      if shots[pointer].strike?
        frames << Frame.new(shots[pointer], Shot.new(nil), Shot.new(nil))
        pointer += 1
      else
        frames << Frame.new(shots[pointer], shots[pointer + 1], Shot.new(nil))
        pointer += 2
      end
    end
    frames
  end
end
