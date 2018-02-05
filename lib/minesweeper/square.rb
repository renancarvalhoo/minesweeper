module Minesweeper
  class Square
    attr_accessor :x, :y, :chosen, :mines_around, :mine, :flagged

    def initialize(x, y)
      @x = x
      @y = y
      
    end
  end
end
