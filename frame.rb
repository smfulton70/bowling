class Frame
  attr_reader :ball_1, :ball_2, :ball_3
  attr_accessor :frame_score

  def initialize(ball_1, ball_2, ball_3)
    @ball_1 = ball_1
    @ball_2 = ball_2
    @ball_3 = ball_3
  end

  def get_frame_pin_total
    @ball_1 + @ball_2 + @ball_3
  end

  def is_strike?
    if @ball_1 == 10
      true
    end
  end

  def is_spare?
    if @ball_1 != 10 && get_frame_pin_total == 10
      true
    end
  end
end
