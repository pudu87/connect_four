require_relative 'board.rb'

class Game

  attr_accessor :board, :player, :pick

  def initialize
    @board = Board.new
    @player = "\u26DB"
    @pick = nil
  end

  def start
    board.show
    until board.victory? || board.full?
      input
      board.show
      puts "Congratulations. #{player} won." if board.victory?
      puts "No more slots left. It's a draw." if board.full?
      switch_player
    end
  end

  private

  def input
    puts "Please select a column to drop your #{player} ."
    @pick = gets.chomp.to_i - 1
    until valid_syntax?(pick) && board.valid_move?(pick)
      valid_syntax?(pick) ? move_error : syntax_error
      @pick = gets.chomp.to_i - 1
    end
    board.insert(pick, player)
  end
  
  def valid_syntax?(pick)
    (0..board.no_columns).include?(pick)
  end

  def switch_player
    player == "\u26DB" ? @player = "\u26DF" : @player = "\u26DB"
  end

  def syntax_error
    puts "Syntax error. Please select a valid column number."
  end

  def move_error
    puts "Move error. This column is full. Please select another column."
  end
end

# game = Game.new
# game.start