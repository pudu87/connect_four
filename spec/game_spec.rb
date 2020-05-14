require './lib/game.rb'

RSpec.describe Game do

  describe "#start" do
    let(:board) { subject.board }
    before do
      allow(subject).to receive(:input).and_return(nil)
      allow(subject).to receive(:switch_player).and_return(nil)
      allow(board).to receive(:show).and_return(nil)
    end
    context "enters the game loop when called" do
      it "and stops when victory is achieved" do
        allow(board).to receive(:victory?).and_return(false, false, true)
        allow(board).to receive(:full?).and_return(false, false)
        expect(board).to receive(:victory?).exactly(3).times
        subject.start
      end
      it "and stops when the board is full" do
        allow(board).to receive(:victory?).and_return(false, false, false)
        allow(board).to receive(:full?).and_return(false, false, true)
        expect(board).to receive(:full?).exactly(3).times
        subject.start
      end
    end
  end

  # PRIVATE

  # describe "#input" do
  #   it "asks for input and processes it" do
  #     expect(STDOUT).to receive(:puts).with(instance_of(String))
  #     allow(subject).to receive(:gets).and_return("1\n")
  #     subject.input
  #     expect(subject.pick).to eq(0)
  #   end
  # end

  # describe "#valid_syntax?" do
  #   it "returns true if input has valid syntax" do
  #     expect(subject.valid_syntax?(1)).to be_truthy
  #   end
  #   it "returns false if input has invalid syntax" do
  #     expect(subject.valid_syntax?(-1)).not_to be_truthy
  #   end
  # end

  # describe "#switch_player" do
  #   it "switches player" do
  #     subject.player = "X"
  #     expect(subject.switch_player).not_to eq("X")
  #   end
  # end

end