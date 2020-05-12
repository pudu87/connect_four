require './lib/game.rb'
require './lib/board.rb'

RSpec.describe Board do

  describe "#show" do
    xit "shows a game board" do
      (ROWS*2+1).times { expect(STDOUT).to receive(:puts).with(instance_of(String)) }
      subject.show
    end
  end

  describe "#insert" do
    xit "inserts a disc in the board" do
      subject.insert(0)
      expect(subject.board[0,ROWS-1]).not_to eq(' ')
    end
  end

  describe "#victory?" do
    xit "checks for horizontal victory" do
      subject.board[0,0] = 'X'
      subject.board[0,1] = 'X'
      subject.board[0,2] = 'X'
      subject.board[0,3] = 'X'
      expect(subject).to be_victory
    end
    xit "checks for vertical victory" do
      subject.board[0,0] = 'X'
      subject.board[1,0] = 'X'
      subject.board[2,0] = 'X'
      subject.board[3,0] = 'X'
      expect(subject).to be_victory
    end
    xit "checks for diagonal victory" do
      subject.board[3,0] = 'X'
      subject.board[2,1] = 'X'
      subject.board[1,2] = 'X'
      subject.board[0,3] = 'X'
      expect(subject).to be_victory
    end
    xit "does not accept anything as a victory" do
      subject.board[0,0] = 'X'
      subject.board[0,1] = 'X'
      subject.board[0,2] = 'O'
      subject.board[0,3] = 'X'
      expect(subject).not_to be_victory
    end
  end

  describe "#valid_move?" do
    xit "returns false if column is full" do
      subject.board[0,0] = 'X'
      expect(subject.valid(0)).not_to be_valid
    end
    xit "returns true if column is not full" do
      subject.board[0,0] = ' '
      expect(subject.valid(0)).to be_valid
    end
  end

end

RSpec.describe Game do

  describe "#start" do
    context "enters the game loop when called" do
      before { allow(subject).to receive(:input).and_return(nil) }
      xit "and stops when victory is achieved" do
        expect_any_instance_of(Board).to receive(:show)
        expect_any_instance_of(Board).to receive(:victory?).and_return(false, true)
        subject.start
        expect_any_instance_of(Board).to receive(:victory?).exactly(2).times
      end
      xit "and stops when the board is full" do
        expect_any_instance_of(Board).to receive(:show)
        expect_any_instance_of(Board).to receive(:full?).and_return(false, true)
        subject.start
        expect_any_instance_of(Board).to receive(:full?).exactly(2).times
      end
    end
  end

  # PRIVATE

  describe "#input" do
    xit "asks for input and processes it" do
      expect(STDOUT).to receive(:puts).with(instance_of(String))
      allow(subject).to receive(:gets).and_return("1\n")
      subject.input
      expect(subject.choice).to eq(0)
    end
  end

  describe "#valid_syntax?" do
    xit "returns true if input has valid syntax" do
      expect(subject.valid?(1)).to be_truthy
    end
    xit "returns false if input has invalid syntax" do
      expect(subject.valid?(-1)).not_to be_truthy
    end
  end

end