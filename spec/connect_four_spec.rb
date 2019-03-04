require "./lib/connect_four"
RSpec.describe Board do
  describe "#initialize" do
    it "creates a 7 by 6 array of arrays full of 1 space strings" do
      board = Board.new
      expect(board.board).to eql(["|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n",
                                  "|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n", "|_|_|_|_|_|_|_|\n", "|1|2|3|4|5|6|7|"])
    end
  end
  describe "#clear" do
    it "clears the board of pieces" do
      board = Board.new
      board.board[0][0] = "t"
      board.clear
      expect(board.board).to eql(Board.new.board)
    end
    it "makes sure there were pieces to clear" do
      board = Board.new
      board.board[0][0] = "t"
      expect(board.board).not_to eql(Board.new.board)
    end
  end
  describe "#enter_move" do
    it "takes a piece and places it on board based on number" do
      board = Board.new
      board.enter_move("o", 4)
      board.enter_move("x", 2)
      expect(board.board[5][7]).to eql("o")
    end
    it "puts pieces on top of others" do
      board = Board.new
      board.enter_move("o", 2)
      board.enter_move("a", 2)
      board.enter_move("i", 2)
      #fourth from the top, and 3rd to the right
      expect(board.board[3][3]).to eql("i")
    end
  end
end
