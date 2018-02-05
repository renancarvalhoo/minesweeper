require 'spec_helper'

describe Minesweeper::Board do

  before :each do
    @board = Minesweeper::Board.new(5,5,5)
  end

  describe "#new" do
    it "takes three parameters and returns a Game object" do
      expect(@board).to be_an_instance_of Minesweeper::Board
    end
  end

  describe 'creates a board ' do
    it 'with rows and columns based in the width and height' do
      board = Minesweeper::Board.new(2, 2, 0)

      expect(4).to eq board.squares.size
    end
  end

  describe 'returns false ' do
    it 'when try to reveal a square revealed before' do
      board = Minesweeper::Board.new(1, 1, 0)

      expect(board.show_square(0, 0)).to eq(true)
      expect(board.show_square(0, 0)).to eq(false)
    end
    it 'when try to reveal a square flagged' do
      board = Minesweeper::Board.new(1, 1, 0)

      expect(board.flag_square(0, 0)).to eq(true)
      expect(board.show_square(0, 0)).to eq(false)
    end
  end


end
