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

  def total_score
    @first_shot + @second_shot
  end

  def get_score(next_frame, frame_after_next)
    if @frame_num >= 10
      self.total_score
    elsif strike?
      if next_frame.strike?
        self.total_score + next_frame.total_score + frame_after_next.first_shot
      else
        self.total_score + next_frame.total_score
      end
    elsif spare?
      self.total_score + next_frame.first_shot
    else
      self.total_score
    end
  end
end
