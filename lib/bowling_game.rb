require_relative 'frame'

class BowlingGame
  attr_reader :frames

  def initialize
    @frames = []
  end

  def roll(no_of_pins)
    current_frame.roll(no_of_pins)
    clear_current_frame if current_frame.complete?
  end

  def frame_at(index)
    frames[index]
  end

  private

  def current_frame
    @current_frame ||= Frame.new(self)
  end

  def clear_current_frame
    @current_frame = nil
  end
end