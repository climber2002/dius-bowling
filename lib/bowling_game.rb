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

  def total_pins_after_frame(current_frame_index, bowls_count)
    bowls = []
    frame_index = current_frame_index + 1
    while bowls.count < bowls_count && (frame = frame_at(frame_index)) do
      bowls.concat(frame.bowls)
      frame_index += 1
    end

    bowls.take(bowls_count).reduce(0) { |sum, no_of_pins| sum + no_of_pins }
  end

  private

  def current_frame
    @current_frame ||= Frame.new(self)
  end

  def clear_current_frame
    @current_frame = nil
  end
end