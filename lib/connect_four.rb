=begin
Board 7 by 6, players, pieces, game
=end
class Board
  attr_accessor :board
  #board coordinates must be accessed by 0-5, then number * 2 - 1
  #index of first row in @board is the top of the board

  def initialize
    @board = ["|_|_|_|_|_|_|_|\n",
              "|_|_|_|_|_|_|_|\n",
              "|_|_|_|_|_|_|_|\n",
              "|_|_|_|_|_|_|_|\n",
              "|_|_|_|_|_|_|_|\n",
              "|_|_|_|_|_|_|_|\n"]
    @board << "|1|2|3|4|5|6|7|"
  end

  def clear
    initialize
  end

  def enter_move(piece, num)
    num = (num * 2) - 1
    level = 5
    while level != -1 && @board[level][num] != "_"
      level -= 1
    end
    if level != -1
      @board[level][num] = piece
    end
  end
end
