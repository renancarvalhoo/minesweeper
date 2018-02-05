module Minesweeper
  class Board
    def initialize(width, height, mines)
       @array_board = Array.new(width) {|w| Array.new(height) {|h| Square.new(w,h) } }
    end
  end
end
