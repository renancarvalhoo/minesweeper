module Minesweeper
  class Square
    attr_accessor :x, :y, :chosen, :mines_around, :mine, :flagged

    def initialize(x, y)
      @x = x
      @y = y
      @chosen = false
      @mine = false
      @flagged = false
      @mines_around = 0
    end


    def choose
      return false if chosen || flagged

      @chosen = true
      true
    end

    def flag
      return false if chosen

      @flagged = !flagged
      true
    end

    def coordinates
      result = { x: x, y: y }

      result[:mines_around] = @mines_around if chosen_and_not_mine

      result
    end

    def mine_chosen
      chosen && mine
    end

    def chosen_and_not_mine
      chosen && !mine
    end

    def unknown_and_empty_tile
      !(mine || flagged || chosen)
    end

    def plant_mine
      @mine = true
    end

    def mines_near_founded
      @mines_around += 1
    end

  end
end
