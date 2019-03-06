require "./lib/connect_four"
describe Board do
  describe "#initialize" do
    it "creates a 7 by 6 array of arrays full of 1 space strings" do
      board = Board.new
      expect(board.show).to eql(["|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n",
                                 "|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n", "|1|2|3|4|5|6|7|\n"])
    end
  end
  describe "#clear" do
    it "clears the board of pieces" do
      board = Board.new
      board.show[0][0] = "t"
      board.clear
      expect(board.show).to eql(Board.new.show)
    end
    it "makes sure there were pieces to clear" do
      board = Board.new
      board.show[0][0] = "t"
      expect(board.show).not_to eql(Board.new.show)
    end
  end
  describe "#enter_move" do
    it "takes a piece and places it on board based on number" do
      board = Board.new
      board.enter_move("o", 4)
      board.enter_move("x", 2)
      expect(board.show[5][7]).to eql("o")
    end
    it "puts pieces on top of others" do
      board = Board.new
      board.enter_move("o", 2)
      board.enter_move("a", 2)
      board.enter_move("i", 2)
      #fourth from the top, and 3rd to the right
      expect(board.show[3][3]).to eql("i")
    end
  end
end
describe Player do
  describe "#piece" do
    it "returns either an x for player 1" do
      player1 = Player.new
      expect(player1.piece).to eql("x")
    end
    it "returns an o for player 2" do
      player1 = Player.new
      player2 = Player.new
      expect(player2.piece).to eql("o")
    end
  end
end
describe Game do
  # describe "#get_input" do
  #   it "Prompts a player for and accepts a single digit number as an input" do
  #     player_input = Game.new.get_input
  #     expect(player_input).to eql(4.to_s)
  #   end
  # end
  describe "#initialize" do
    it "Creates instance of game variables including Board." do
      game = Game.new
      expect(game.board.show).not_to eql(nil)
    end
  end
  describe "#prompt" do
    it "Displays the board and aks for input specific to player" do
      game = Game.new
      expect(game.prompt(game.turn)).not_to eql(nil)
    end
  end
  describe "#win_check" do
    it "checks if there is a vertical winning position" do
      game = Game.new
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 3)
      expect(game.check_win).to eql(true)
    end
    it "checks if there is not a vertical winning position" do
      game = Game.new
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 2)
      game.board.enter_move(game.player1.piece, 3)
      expect(game.check_win).to eql(false)
    end
    it "checks if there is a horizontal winning position." do
      game = Game.new
      game.board.enter_move(game.player1.piece, 4)
      game.board.enter_move(game.player1.piece, 5)
      game.board.enter_move(game.player1.piece, 6)
      game.board.enter_move(game.player1.piece, 7)
      expect(game.check_win).to eql(true)
    end
    it "checks if there is a diagonal winning position" do
      game = Game.new
      game.board.enter_move(game.player1.piece, 4)
      game.board.enter_move(game.player2.piece, 3)
      game.board.enter_move(game.player1.piece, 2)
      game.board.enter_move(game.player2.piece, 1)
      game.board.enter_move(game.player1.piece, 3)

      game.board.enter_move(game.player2.piece, 2)
      game.board.enter_move(game.player1.piece, 1)
      game.board.enter_move(game.player1.piece, 2)
      game.board.enter_move(game.player2.piece, 1)
      game.board.enter_move(game.player1.piece, 1)
      expect(game.check_win).to eql(true)
    end
  end
  describe "#change_turn" do
    it "changes a number that determines whose turn it is" do
      game = Game.new
      game.change_turn
      expect(game.turn).to eql(2)
    end
  end
  describe "#show_winner" do
    it "returns a string with a winner congratulation" do
      game = Game.new
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 3)
      game.board.enter_move(game.player1.piece, 3)
      expect(game.show_winner(game.turn)).to eql("Winner player1")
    end
  end
  describe "#reset" do
    it "Resets the board for a new game" do
      game = Game.new
      game.board.enter_move(game.player1.piece, 3)
      game.reset
      expect(game.board.show).to eql(Board.new.show)
    end
  end
end
