require 'bowling_game'

describe BowlingGame do
  subject { described_class.new }

  context 'when has a strike for every roll' do
    before do
      12.times { subject.roll(10) }
    end

    it 'has score 300' do
      expect(subject.score).to eq 300
    end
  end

  context 'when rolls some strikes and some spares, with last frame is a spare' do
    before do
      subject.roll(10)

      subject.roll(7)
      subject.roll(3)

      subject.roll(7)
      subject.roll(2)

      subject.roll(9)
      subject.roll(1)

      subject.roll(10)

      subject.roll(10)

      subject.roll(10)

      subject.roll(2)
      subject.roll(3)

      subject.roll(6)
      subject.roll(4)

      subject.roll(7)
      subject.roll(3)
      subject.roll(3)
    end

    it { expect(subject.score).to eq 168 }
  end

  context 'when rolls some strikes and some spares, with last frame is neither a spare nor a strike' do
    before do
      subject.roll(10)

      subject.roll(7)
      subject.roll(3)

      subject.roll(7)
      subject.roll(2)

      subject.roll(9)
      subject.roll(1)

      subject.roll(10)

      subject.roll(10)

      subject.roll(10)

      subject.roll(2)
      subject.roll(3)

      subject.roll(6)
      subject.roll(4)

      subject.roll(7)
      subject.roll(2)
    end

    it { expect(subject.score).to eq 164 }
  end
end