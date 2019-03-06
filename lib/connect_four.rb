=begin
Board 7 by 6, players, game
=end
class Board
  attr_accessor :show
  #board coordinates must be accessed by 0-5, then number * 2 - 1
  #index of first row in @board is the top of the board

  def initialize
    @show = ["|_|_|_|_|_|_|_|\n",
             "|_|_|_|_|_|_|_|\n",
             "|_|_|_|_|_|_|_|\n",
             "|_|_|_|_|_|_|_|\n",
             "|_|_|_|_|_|_|_|\n",
             "|_|_|_|_|_|_|_|\n"]
    @show << "|1|2|3|4|5|6|7|\n"
  end

  def clear
    initialize
  end

  def enter_move(piece, num)
    num = (num * 2) - 1
    level = 5
    while level != -1 && @show[level][num] != "_"
      level -= 1
    end
    if level != -1
      @show[level][num] = piece
    end
  end
end

class Player
  attr_reader :piece
  @@number_players = 0

  def initialize
    @@number_players += 1
    if @@number_players == 1
      @piece = "x"
    else
      @piece = "o"
    end
  end
end

class Game
  attr_accessor :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
  end

  def get_input
    puts "Attention player, please enter a corresponding number."
    player_input = gets.chomp
    until player_input =~ /^[1-7]$/
      puts "Invalid input, please try again."
      player_input = gets.chomp
    end
    return player_input
  end
end
