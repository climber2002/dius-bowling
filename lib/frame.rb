class Frame
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
    bowls[0] == 10
  end

  def spare?
    !strike? && total_pins == 10
  end

  private

  def total_pins
    bowls.reduce(0) { |sum, pins| sum + pins }
  end
end