require 'bowling_game'
require 'last_frame'

describe LastFrame do
  describe '#roll' do
    let(:bowling_game) do
      bowling_game = BowlingGame.new
      9.times { bowling_game.roll(10) }
      bowling_game
    end

    subject { described_class.new(bowling_game) }

    context 'when firstly roll a strike' do
      before do
        subject.roll(10)
      end

      it { expect(subject.strike?).to be_truthy }
      it { expect(subject.complete?).to be_falsy }
      
      context 'then roll once' do
        before do
          subject.roll(10)
        end

        it { expect(subject.strike?).to be_truthy }
        it { expect(subject.complete?).to be_falsy }
      end

      context 'when roll twice' do
        before do
          subject.roll(5)
          subject.roll(4)
        end

        it { expect(subject.strike?).to be_truthy }
        it { expect(subject.complete?).to be_truthy }
      end
    end

    context 'when firstly roll a spare' do
      before do
        subject.roll(6)
        subject.roll(4)
      end

      it { expect(subject.spare?).to be_truthy }
      it { expect(subject.complete?).to be_falsy }
      
      context 'then roll once' do
        before do
          subject.roll(10)
        end

        it { expect(subject.spare?).to be_truthy }
        it { expect(subject.complete?).to be_truthy }
      end
    end

    context 'when firstly roll neither a spare nor strike' do
      before do
        subject.roll(5)
        subject.roll(4)
      end

      it { expect(subject.spare?).to be_falsy }
      it { expect(subject.strike?).to be_falsy }
      it { expect(subject.complete?).to be_truthy }
    end
  end
end