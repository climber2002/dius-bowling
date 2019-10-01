class Frame
  attr_reader :index, :bowling_game, :bowls

  # the Frame index starts at 0
  def initialize(index, bowling_game)
    @index = index
    @bowling_game = bowling_game
    @bowls = []
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
end