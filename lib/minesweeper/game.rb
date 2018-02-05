module Minesweeper
  class Game
    attr_reader :board, :width, :height

    def initialize(width = 3, height = 3, mines = 3)
      @width = width; @height = height; @mines = mines

      if @mines >= (@width * @height)
        raise ArgumentError, 'You pass more mines than the board holds'
      end

      @board = Board.new(width, height, mines)
    end


    def board_state(settings = { show_mines: false })
      settings[:show_mines] = false if still_playing?

      @board.control_settings(settings).merge(
        board_configuration: { width: @width, height: @height }
      )
    end

    def still_playing?
      control = @board.control_settings

      return true if control[:flagged].size > @mines

      !control[:exploded].empty? || control[:not_chosen].empty? ? false : true
    end

    def flag(coordinates)
      return false unless still_playing?

      x = coordinates.fetch(:x)
      y = coordinates.fetch(:y)

      validate_coordinates(x, y)

      @board.flag_square(x - 1, y - 1)
    end

    def play(coordinates)
      return false unless still_playing?

      x = coordinates.fetch(:x)
      y = coordinates.fetch(:y)

      validate_coordinates(x, y)



      @board.show_square(x - 1, y - 1)
    end

    def victory?
      board_state[:exploded].empty? && !still_playing? ? true : false
    end

    private

    def validate_coordinates(x, y)
      if x <= 0 || y <= 0
        raise ArgumentError, 'You need to pass positive values'
      elsif x > @width
        raise ArgumentError, "You can use X coordinate as maximium: #{@width}"
      elsif y > @height
        raise ArgumentError, "You can use X coordinate as maximium: #{@height}"
      end
    end
  end
end
