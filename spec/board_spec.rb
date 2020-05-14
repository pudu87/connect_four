require './lib/board.rb'

RSpec.describe Board do
  
  describe "#show" do
    it "shows a game board" do
      discs = subject.no_rows * subject.no_columns
      expect(STDOUT).to receive(:puts).at_least(:twice)
      expect(subject).to receive(:print).at_least(discs).times
      subject.show
    end
  end

  describe "#insert" do
    it "inserts a disc in the board" do
      subject.insert(0, 'X')
      expect(subject.board[-1][0]).not_to eq(" ")
    end
  end

  describe "#victory?" do
    it "checks for horizontal victory" do
      subject.board[0][0] = 'X'
      subject.board[0][1] = 'X'
      subject.board[0][2] = 'X'
      subject.board[0][3] = 'X'
      expect(subject).to be_victory
    end
    it "checks for vertical victory" do
      subject.board[0][0] = 'X'
      subject.board[1][0] = 'X'
      subject.board[2][0] = 'X'
      subject.board[3][0] = 'X'
      expect(subject).to be_victory
    end
    it "checks for downward diagonal victory" do
      subject.board[0][0] = 'X'
      subject.board[1][1] = 'X'
      subject.board[2][2] = 'X'
      subject.board[3][3] = 'X'
      expect(subject).to be_victory
    end
    it "checks for upward diagonal victory" do
      subject.board[3][0] = 'X'
      subject.board[2][1] = 'X'
      subject.board[1][2] = 'X'
      subject.board[0][3] = 'X'
      expect(subject).to be_victory
    end
    it "does not accept anything as a victory" do
      subject.board[0][0] = 'X'
      subject.board[0][1] = 'X'
      subject.board[0][2] = 'X'
      subject.board[0][3] = 'O'
      subject.board[0][-1] = 'X'
      expect(subject).not_to be_victory
    end
  end

  describe "#valid_move?" do
    it "returns false if column is full" do
      subject.board[0,0] = 'X'
      expect(subject.valid_move?(0)).not_to be_truthy
    end
    it "returns true if column is not full" do
      subject.board[0,0] = ' '
      expect(subject.valid_move?(0)).to be_truthy
    end
  end

  describe "#full?" do
    it "returns true if the board is full" do
      subject.board[0].fill('X')
      expect(subject).to be_full
    end
    it "returns false if the board is not full" do
      subject.board[0][0] = 'X'
      subject.board[0][1] = ' '
      expect(subject).not_to be_full
    end
  end

end