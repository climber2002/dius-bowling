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

      context 'when roll two 0 pins' do
        before do
          subject.roll(0)
          subject.roll(0)
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

    context 'when roll into the last frame' do
      before do
        10.times { subject.roll(10) }
      end

      it 'should has first 9 frames as type Frame' do
        (0..8).each do |index|
          expect(subject.frame_at(index).class).to eq Frame
        end
      end

      it 'should has last frame as type LastFrame' do
        expect(subject.frame_at(9).class).to eq LastFrame
      end
    end

    context 'when roll after the game completes' do
      before do
        12.times { subject.roll(10) }
      end

      it 'does not accept roll anymore' do
        expect{ subject.roll(3) }.to change{ subject.score }.by(0)
      end
    end
  end

  describe '#score' do
    context 'when roll 3 non strike nor spare' do
      before do
        subject.roll(3)
        subject.roll(5)

        subject.roll(2)
        subject.roll(4)

        subject.roll(3)
        subject.roll(4)
      end

      it 'the score is total score of the 3 frames' do
        expect(subject.score).to eq (8 + 6 + 7)
      end
    end
    
    context 'when roll 3 strike' do
      before do
        subject.roll(10)
        subject.roll(10)
        subject.roll(10)
      end

      it 'the score is total score of the 3 frames' do
        expect(subject.score).to eq (30 + 20 + 10)
      end
    end

    context 'when roll a sqare, two non strikes nor sqares' do
      before do
        subject.roll(7)
        subject.roll(3)

        subject.roll(2)
        subject.roll(3)
        
        subject.roll(4)
        subject.roll(5)
      end

      it 'the score is total score of the 3 frames' do
        expect(subject.score).to eq (12 + 5 + 9)
      end
    end
  end

  describe '#game_complete?' do
    context 'when there are less than 10 frames' do
      before do
        subject.roll(10)
        subject.roll(10)
      end

      it { expect(subject.game_complete?).to be_falsy }
    end

    context 'when there are 10 frames and the last frame is strike' do
      before do
        10.times { subject.roll(10) }
      end

      it { expect(subject.game_complete?).to be_falsy }

      context 'then roll twice' do
        before do
          subject.roll(10)
          subject.roll(5)
        end

        it { expect(subject.game_complete?).to be_truthy }
      end
    end

    context 'when there are 10 frames and the last frame is spare' do
      before do
        9.times { subject.roll(10) }
        subject.roll(7)
        subject.roll(3)
      end

      it { expect(subject.game_complete?).to be_falsy }

      context 'then roll once' do
        before do
          subject.roll(10)
        end

        it { expect(subject.game_complete?).to be_truthy }
      end
    end

    context 'when there are 10 frames and the last frame is neither strike nor spare' do
      before do
        9.times { subject.roll(10) }
        subject.roll(4)
        subject.roll(3)
      end

      it { expect(subject.game_complete?).to be_truthy }
    end
  end

  describe '#total_pins_after_frame' do
    let(:current_frame_index) { 0 }

    before do
      subject.roll(10)
    end

    context 'when bowls_count is 1' do
      let(:bowls_count) { 1 }

      context 'when there is no frames after the current frame' do
        it 'returns 0' do
          expect(subject.total_pins_after_frame(current_frame_index, bowls_count)).to eq 0
        end
      end

      context 'when there is a frame after current frame' do
        before do
          subject.roll(3)
          subject.roll(4)
        end

        it 'returns the no of pins in first bowl of the next frame' do
          expect(subject.total_pins_after_frame(current_frame_index, bowls_count)).to eq 3
        end
      end
    end

    context 'when bowls_count is 2' do
      let(:bowls_count) { 2 }

      context 'when there is no frames after the current frame' do
        it 'returns 0' do
          expect(subject.total_pins_after_frame(current_frame_index, bowls_count)).to eq 0
        end
      end

      context 'when the next two bowls are in same frame' do
        before do
          subject.roll(3)
          subject.roll(4)
          subject.roll(5)
        end

        it 'returns the no of pins in first bowl of the next frame' do
          expect(subject.total_pins_after_frame(current_frame_index, bowls_count)).to eq 7
        end
      end

      context 'when the next two bowls are in different frames' do
        before do
          subject.roll(10)
          subject.roll(4)
          subject.roll(5)
        end

        it 'returns the no of pins in bowls of the next 2 frame' do
          expect(subject.total_pins_after_frame(current_frame_index, bowls_count)).to eq 14
        end
      end
    end
  end
end