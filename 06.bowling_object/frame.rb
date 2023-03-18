# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_shot, second_shot, frame_num)
    @first_shot = first_shot
    @second_shot = second_shot
    @frame_num = frame_num
  end

  def strike?
    @first_shot == 10
  end

  def spare?
    return false if strike?

    @first_shot + @second_shot == 10
  end

  def get_score(next_frame, frame_after_next)
    if @frame_num >= 10
      @first_shot + @second_shot
    elsif strike?
      if next_frame.strike?
        20 + frame_after_next.first_shot
      else
        10 + next_frame.first_shot + next_frame.second_shot
      end
    elsif spare?
      10 + next_frame.first_shot
    else
      @first_shot + @second_shot
    end
  end
end
