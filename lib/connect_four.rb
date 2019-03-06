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
    num = (num.to_i * 2) - 1
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
  attr_accessor :board, :player1, :player2, :turn

  def initialize
    @turn = 1
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
  end

  def get_input
    player_input = gets.chomp
    until player_input =~ /^[1-7]$/
      puts "Invalid input, please try again."
      player_input = gets.chomp
    end
    return player_input
  end

  def prompt(player_number)
    return @board.show.join + "Select a corresponding number, player#{player_number}"
  end

  def check_win
    def virtical
      (1..7).each do |x|
        x = x * 2 - 1
        counter = 0
        current = nil
        (0..5).each do |line|
          line = @board.show[line]
          if current == nil
            current = line[x]
            counter = 1
          elsif current == line[x]
            counter += 1
          else
            current = line[x]
            counter = 1
          end
          if counter == 4 && current != "_"
            return true
          end
        end
      end
      return false
    end

    def horizontal
      (0..5).each do |line|
        line = @board.show[line]
        counter = 0
        current = nil
        (1..7).each do |x|
          x = x * 2 - 1
          if current == nil
            current = line[x]
            counter = 1
          elsif current == line[x]
            counter += 1
          else
            current = line[x]
            counter = 1
          end
          if counter == 4 && current != "_"
            return true
          end
        end
      end
      return false
    end

    def diagonal
      b = @board.show
      l_starts = [[3, 1], [4, 1], [5, 1], [5, 2], [5, 3], [5, 4]]
      r_starts = [[3, 7], [4, 7], [5, 7], [5, 6], [5, 5], [5, 4]]

      l_starts.each do |y, x|
        x = x * 2 - 1
        current = b[y][x]
        x += 2
        y -= 1
        counter = 1
        while x > 0 && y > -1
          if current == b[y][x]
            counter += 1
          elsif current != b[y][x]
            counter = 1
          end
          if counter == 4 && current != "_"
            return true
          end
          current = b[y][x]
          x += 2
          y -= 1
        end
      end
      r_starts.each do |y, x|
        x = x * 2 - 1
        current = b[y][x]
        x -= 2
        y -= 1
        counter = 1
        while x < 14 && y > -1
          if current == b[y][x]
            counter += 1
          elsif current != b[y][x]
            counter = 1
          end
          if counter == 4 && current != "_"
            return true
          end
          current = b[y][x]
          x -= 2
          y -= 1
        end
      end
      return false
    end

    return (virtical || horizontal || diagonal)
  end

  def show_winner(number)
    return "Winner player#{number}"
  end

  def change_turn
    if @turn == 1
      @turn = 2
    else
      @turn = 1
    end
  end

  def reset
    @turn = 1
    @board.clear
  end
end

def game_loop(game)
  while true
    puts game.prompt(game.turn)
    if game.turn == 1
      game.board.enter_move(game.player1.piece, game.get_input)
    else
      game.board.enter_move(game.player2.piece, game.get_input)
    end
    if game.check_win
      puts game.show_winner(game.turn)
      game.reset
    else
      game.change_turn
    end
  end
end

game = Game.new
game_loop(game)
