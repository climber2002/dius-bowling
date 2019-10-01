class Frame
  TOTAL_PINS_IN_A_FRAME = 10

  attr_reader :index, :bowling_game, :bowls

  def initialize(bowling_game)
    @bowling_game = bowling_game
    @bowls = []
    @index = bowling_game.frames.length
    @bowling_game.frames << self
  end

  def roll(no_of_pins)
    @bowls << no_of_pins
  end

  def complete?
    strike? || bowls.length == 2
  end

  def strike?
    total_pins_of_first_n_bowls(1) == TOTAL_PINS_IN_A_FRAME
  end

  def spare?
    !strike? && total_pins_of_first_n_bowls(2) == TOTAL_PINS_IN_A_FRAME
  end

  def score
    return total_pins + total_pins_after_me(2) if strike?
    return total_pins + total_pins_after_me(1) if spare?
    total_pins
  end

  private

  def total_pins
    total_pins_of_first_n_bowls(bowls.count)
  end

  def total_pins_of_first_n_bowls(bowls_count)
    bowls.take(bowls_count).reduce(0) { |sum, pins| sum + pins }
  end

  def total_pins_after_me(bowls_count)
    bowling_game.total_pins_after_frame(index, bowls_count)
  end
end
