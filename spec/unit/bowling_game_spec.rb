require 'bowling_game'

describe BowlingGame do
  subject { described_class.new }

  describe '#initialize' do
    it 'has no frames' do
      expect(subject.frames.empty?).to be_truthy
    end
  end

  describe '#roll' do
    context 'when roll once' do
      context 'when roll a strike' do
        before do
          subject.roll(10)
        end

        it 'creates one frame' do
          expect(subject.frames.length).to eq 1
        end

        it 'the frame has index 0' do
          frame = subject.frame_at(0)
          expect(frame.index).to eq 0
        end

        it 'has a strike frame' do
          frame = subject.frame_at(0)
          expect(frame.strike?).to be_truthy
        end
      end
    end
  end
end