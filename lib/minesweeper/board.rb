module Minesweeper
  class Board
    attr_reader :array

    def initialize(width, height, mines)

      board_created = Array.new(width) {|w| Array.new(height) {|h| Square.new(w,h) } }

      @array = board_created.flatten

      @array.sample(mines).each do |square|
        square.mine = true
      end

      binding.pry
    end

    def control_settings(settings = {})
      result = {
        not_chosen: @array.reject(&:chosen).reject(&:flag).collect(&:coordinates),
        exploded:   @array.select(&:mine_chosen).collect(&:coordinates),
        chosen:     @array.select(&:chosen_and_not_mine).collect(&:coordinates),
        flagged:    @array.select(&:flagged).collect(&:coordinates)
      }

      if settings[:show_mines]
        result[:all_mines] = @array.select(&:mine).collect(&:coordinates)
      end

      result
    end

    def show_square(x, y)

      square = @array.detect {|square| square.x.eql?(x) && square.y.eql?(y)}

      return false unless square.choose

      reveal_neighboards(square) unless square.mine

      true
    end

    private

    def reveal_neighboards(current_square)
      near_squares = find_near_tiles(current_square)

      near_squares_with_mines = near_squares.select(&:mine)

      if !near_squares_with_mines.empty? && current_tile.mines_near.zero?
        near_squares_with_mines.size.times { current_tile.mines_near_founded }
      else
        near_squares.select(&:unknown_and_empty_tile).each do |square|
          square.choose
          reveal_neighboards(square)
        end
      end
    end

    def find_near_squares(square)
      x = square.x
      y = square.y

      near_squares = (-1..1).to_a.product((-1..1).to_a).reject { |dx, dy| dx == 0 && dy == 0 }

      binding.pry
      near_squares.map { |dx, dy| [x + dx][y + dy] }.reject{|coordinate| coordinate[0] < 0 || coordinate[1] < 0}

    end

    def find_near_tiles(tile)
      x = tile.x
      y = tile.y

      result = [x - 1, x, x + 1]
        .product([y - 1, y, y + 1])
        .reject { |coordinate| coordinate[0] < 0 || coordinate[1] < 0 }

      result.delete([x, y])

      result
    end

  end

end