require_relative 'frame'
require_relative 'last_frame'

class BowlingGame
  TOTAL_FRAMES_IN_A_MATCH = 10

  attr_reader :frames

  def initialize
    @frames = []
  end

  def roll(no_of_pins)
    return if game_complete?

    current_frame.roll(no_of_pins)
    clear_current_frame if current_frame.complete?
  end

  def game_complete?
    frames.length == TOTAL_FRAMES_IN_A_MATCH && frames.all?(&:complete?)
  end

  def frame_at(index)
    frames[index]
  end

  def score
    frames.reduce(0) { |sum, frame| sum + frame.score }
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
    @current_frame ||= create_new_frame
  end

  def create_new_frame
    frames.length < (TOTAL_FRAMES_IN_A_MATCH - 1) ? Frame.new(self) : LastFrame.new(self)
  end

  def clear_current_frame
    @current_frame = nil
  end
end