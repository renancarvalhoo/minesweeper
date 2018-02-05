module Minesweeper
  class Board
    def initialize(width, height, mines)

      board_created = Array.new(width) {|w| Array.new(height) {|h| Square.new(w,h) } }

      @array = board_created.flatten
    end

  end
end
