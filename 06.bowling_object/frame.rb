# frozen_string_literal: true

class Frame
  def initialize(first_shot, second_shot, third_shot)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    return false if strike?

    @first_shot.score + @second_shot.score == 10
  end

  def total_score
    @first_shot.score + @second_shot.score + @third_shot.score
  end

  def first_shot_score
    @first_shot.score
  end

  def first_and_second_shot_score
    @first_shot.score + @second_shot.score
  end
end
