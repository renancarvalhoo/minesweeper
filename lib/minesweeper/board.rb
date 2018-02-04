module Minesweeper
  class Board
    def initialize(width, height, mines)
      @array = Array.new(width, Array.new(height, 1))
    end
  end
end
