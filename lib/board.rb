class Board

  attr_accessor :board, :no_rows, :no_columns

  def initialize
    @no_rows = 6
    @no_columns = 7
    @board = Array.new(no_rows) { Array.new(no_columns, " ") }
  end

  def show
    puts
    board.each_with_index do |row|
      row.each { |e| print "| #{e} " }
      print "|\n"
      no_columns.times { print "  - " }
      puts
    end
    puts
    no_columns.times { |e| print "  #{e + 1} "}
    puts
  end

  def insert(column, player)
    row = board.index { |row| row[column] != " " }.to_i
    board[row-1][column] = player
  end

  def valid_move?(column)
    board[0][column] == " "
  end

  def victory?
    horizontal_victory? || vertical_victory? || 
    diagonal_victory_down? || diagonal_victory_up?
  end

  def full?
    board[0].none?(/^ $/)
  end

  private

  def horizontal_victory?(board=@board)
    board.each do |row|
      row.each_index do |i, array=[]|
        4.times { |n| array << row[i+n] }
        return true if connected?(array)
      end
    end
    false
  end

  def vertical_victory?
    horizontal_victory?(board.transpose)
  end

  def diagonal_victory_down?(board=@board)
    board.each_index do |r|
      board[r].each_index do |c, array = []|
        4.times { |n| array << board[r+n][c+n] if board[r+n] }
        return true if connected?(array)
      end
    end
    false
  end

  def diagonal_victory_up?
    diagonal_victory_down?(board.map(&:reverse))
  end

  def connected?(array)
    array.size == 4 && array.uniq.size == 1 && array[0] != " "
  end

end