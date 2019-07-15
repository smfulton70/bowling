require 'io/console'
require_relative 'frame'

class Game
  attr_reader :name, :frames

  def initialize(name)
    @name = name
    @frames = []
    puts "Welcome to the game, #{@name}"
    bowl
  end

  def bowl
    if @frames.length == 0
      puts "Press any key to begin bowling.\n"
    else
      puts "Press any key to bowl again.\n"
    end
    #if gets.chomp == " "
      STDIN.getch
      puts ""
      puts "Frame #{@frames.length+1}"
      puts ""
      ball_1 = roll_ball(11)
      if ball_1 == 10
        puts "Strike!"
        @frames.push(Frame.new(ball_1, 0, 0))
      else
        puts "Ball 1: #{ball_1}"
        ball_2 = roll_ball(11 - ball_1)
        puts "Ball 2: #{ball_2}"
        if ball_1 + ball_2 == 10
          puts "Spare!"
        end
        @frames.push(Frame.new(ball_1, ball_2, 0))
      end
      puts ""
      puts "Your score is now #{calculate_score}"
      puts ""
      if @frames.length < 9
        bowl
      else
        bowl_10th
      end
    #end
  end

  def bowl_10th
    puts "Press any key to bowl again.\n"
    STDIN.getch
    puts ""
    puts "Frame 10"
    puts ""
    ball_1 = roll_ball(11)
    puts "Ball 1: #{ball_1}"
    if ball_1 == 10
      puts "Strike!"
      ball_2 = roll_ball(11)
      puts "Ball 2: #{ball_2}"
      if ball_2 == 10
        puts "Strike!"
        ball_3 = roll_ball(11)
        puts "Ball 3: #{ball_3}"
        if ball_3 == 10
          puts "Strike!"
        end
      else
        ball_3 = roll_ball(11 - ball_2)
        puts "Ball 3: #{ball_3}"
        if ball_3 == 10
          puts "Strike!"
        end
      end
    else
      ball_2 = roll_ball(11 - ball_1)
      puts "Ball 2: #{ball_2}"
      if ball_1 + ball_2 == 10
        puts "Spare!"
        ball_3 = roll_ball(11 - ball_2)
        puts "Ball 3: #{ball_3}"
        if ball_3 == 10
          puts "Strike!"
        end
      end
    end
    @frames.push(Frame.new(ball_1, ball_2, ball_3 ? ball_3 : 0))
    puts "Your final score is #{calculate_score}"
    puts ""
  end

  def roll_ball(number)
    rand(number)
  end

  def calculate_score
    #most recently completed frame
    current_frame = @frames[-1]
    #2nd to most recently completed frame
    previous_frame = @frames[@frames.length-2]
    if @frames.length == 1
      current_frame.frame_score = current_frame.get_frame_pin_total
    else
      #in case of strike, add the total pins from BOTH balls rolled in the current frame to the frame score of previous frame.
      if previous_frame.is_strike?
        previous_frame.frame_score += current_frame.get_frame_pin_total
      #in case of spare, add the pins knocked over from first ball rolled in the current frame to the frame score of previous frame.
      elsif previous_frame.is_spare?
        previous_frame.frame_score +=
        current_frame.ball_1
      end
      current_frame.frame_score = previous_frame.frame_score + current_frame.get_frame_pin_total
    end
  end
end
