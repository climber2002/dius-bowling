require_relative 'frame'

class LastFrame < Frame
  def complete?
    return bowls.count == 3 if strike? || spare?
    super
  end
end
