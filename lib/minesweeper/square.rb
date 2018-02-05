module Minesweeper
  class Square
    attr_accessor :x, :y, :chosen, :mines_around, :mine, :flagged

    def initialize(x, y)
      @x = x
      @y = y
      @chosen = false
      @mines_around = false
      @mine = false
    end
  end
end
