module Minesweeper
  class Game

    def initialize(width = 3, height = 3, mines = 3)
      @width = width; @height = height; @mines = mines

      @board = Board.new(width, height, mines)
    end


  end
end
