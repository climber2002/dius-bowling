require 'frame'
require 'bowling_game'

describe Frame do
  let(:bowling_game) { BowlingGame.new }
  subject { Frame.new(bowling_game) }

  describe '#initialize' do
    context 'when the BowlingGame has no frames yet' do
      before do
        subject
      end

      it { expect(subject.bowling_game).to eq bowling_game }
      it { expect(subject.index).to eq 0 }
      it { expect(subject.bowls.empty?).to be_truthy }

      it 'adds the frame into the bowling game' do
        expect(bowling_game.frames.length).to eq 1
      end

      it 'is the first frame of the BowlingGame' do
        expect(bowling_game.frame_at(0)).to eq subject
      end
    end
    
    context 'when the BowlingGame already has frames' do
      before do
        Frame.new(bowling_game)
        Frame.new(bowling_game)
        subject
      end

      it { expect(subject.bowling_game).to eq bowling_game }
      it 'has correct index' do
        expect(subject.index).to eq 2
      end

      it 'adds the frame into the bowling game' do
        expect(bowling_game.frames.length).to eq 3
      end

      it 'is the last frame of the BowlingGame' do
        expect(bowling_game.frames.last).to eq subject
      end
    end
  end

  describe '#roll' do
    subject { Frame.new(bowling_game) }

    context 'when roll 10 for once' do
      before do
        subject.roll(10)
      end

      it { expect(subject.strike?).to be_truthy }
      it { expect(subject.spare?).to be_falsy } 
      it { expect(subject.complete?).to be_truthy }
    end

    context 'when roll less than 10 for once' do
      before do
        subject.roll(3)
      end

      it { expect(subject.strike?).to be_falsy }
      it { expect(subject.spare?).to be_falsy }
      it { expect(subject.complete?).to be_falsy }
    end

    context 'when roll twice for a spare' do
      before do
        subject.roll(3)
        subject.roll(7)
      end

      it { expect(subject.strike?).to be_falsy }
      it { expect(subject.spare?).to be_truthy }
      it { expect(subject.complete?).to be_truthy }
    end

    context 'when roll twice which is NOT a spare' do
      before do
        subject.roll(3)
        subject.roll(4)
      end

      it { expect(subject.strike?).to be_falsy }
      it { expect(subject.spare?).to be_falsy }
      it { expect(subject.complete?).to be_truthy }
    end
  end
end