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

  def insert(column)
    row = board.index { |row| row[column] != " " }.to_i
    board[row-1][column] = "X"
  end

  def valid_move?(column)
    board[0][column] == " "
  end

  def victory?
    horizontal_victory? || vertical_victory? || 
    down_diagonal_victory? || up_diagonal_victory?
  end

  def horizontal_victory?(board=@board)
    board.each do |row|
      counter = 0
      row.each_index do |i|
        if i > 0
          (row[i] == row[i-1] && row[i] != " ") ? counter += 1 : counter = 0
          return true if counter == 3
        end
      end
    end
    false
  end

  def vertical_victory?
    horizontal_victory?(board.transpose)
  end

  def down_diagonal_victory?(board=@board)
    board.each_index do |r|
      board[r].each_index do |c|
        counter = 0
        4.times do |n|
          if (0...no_rows).include?(r+n) && (0...no_columns).include?(c+n)
            (board[r][c] == board[r+n][c+n] && board[r][c] != " ") ? counter += 1 : counter = 0
            return true if counter == 4
          end
        end
      end
    end
    false
  end

  def up_diagonal_victory?
    down_diagonal_victory?(board.map(&:reverse))
  end

end

# test = Board.new
# test.show