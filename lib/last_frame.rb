require_relative 'frame'

class LastFrame < Frame
  def complete?
    return bowls.count == 3 if strike? || spare?
    bowls.length == 2
  end

  def spare?
    !strike? && total_pins_of_first_n_bowls(2) == TOTAL_PINS_IN_A_FRAME
  end

  private

  def total_pins_of_first_n_bowls(bowls_count)
    bowls.take(bowls_count).reduce(0) { |sum, pins| sum + pins }
  end
end