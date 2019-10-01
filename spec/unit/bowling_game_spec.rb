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

      context 'when roll a non strike' do
        before do
          subject.roll(5)
        end

        it 'creates one frame' do
          expect(subject.frames.length).to eq 1
        end

        it 'the frame has index 0' do
          frame = subject.frame_at(0)
          expect(frame.index).to eq 0
        end

        it 'has a NON strike frame' do
          frame = subject.frame_at(0)
          expect(frame.strike?).to be_falsy
        end
      end
    end

    context 'when roll twice' do
      context 'when the both rolls are strike' do
        before do
          subject.roll(10)
          subject.roll(10)
        end

        it 'creates two frames' do
          expect(subject.frames.length).to eq 2
        end

        it 'has two strike frames' do
          subject.frames.each do |frame|
            expect(frame.strike?).to be_truthy
          end
        end
      end

      context 'when roll a spare' do
        before do
          subject.roll(4)
          subject.roll(6)
        end

        it 'creates one frame' do
          expect(subject.frames.length).to eq 1
        end

        it 'has a spare frame' do
          frame = subject.frame_at(0)
          expect(frame.spare?).to be_truthy
        end
      end

      context 'when roll a non spare' do
        before do
          subject.roll(4)
          subject.roll(5)
        end

        it 'creates one frame' do
          expect(subject.frames.length).to eq 1
        end

        it 'has a spare frame' do
          frame = subject.frame_at(0)
          expect(frame.spare?).to be_falsy
          expect(frame.complete?).to be_truthy
        end
      end
    end

    context 'when roll 3 times' do
      context 'when the all rolls are strike' do
        before do
          subject.roll(10)
          subject.roll(10)
          subject.roll(10)
        end

        it 'creates 3 frames' do
          expect(subject.frames.length).to eq 3
        end

        it 'has 3 strike frames' do
          subject.frames.each do |frame|
            expect(frame.strike?).to be_truthy
          end
        end
      end

      context 'when roll a spare first' do
        before do
          subject.roll(3)
          subject.roll(7)
          subject.roll(6)
        end

        it 'creates 2 frames' do
          expect(subject.frames.length).to eq 2
        end

        it 'has first frame as spare' do
          expect(subject.frame_at(0).spare?).to be_truthy
        end

        it 'has the second frame as NOT complete' do
          expect(subject.frame_at(1).complete?).to be_falsy
        end
      end
    end
  end
end