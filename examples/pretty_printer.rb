class PrettyPrinter < SimplePrinter
  def board_format
    {
      unknown_cell: "⬛️",
      clear_cell: "⬜️",
      mine: "💣",
      flag: "🚩"
    }
  end

  def print(board_state)
    board_configuration = board_state.fetch(:board_configuration)
    rows = board_configuration.fetch(:width)
    columns = board_configuration.fetch(:height)

    build_board(rows, columns, board_state)

    @board.each do |row|
      puts row.join(" ")
    end
  end

  private

  def populate_revealed_tile(tiles)
    emoji_numbers = %w(0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ )
    tiles.each do |tile|
      @board[tile[:x]][tile[:y]] = if tile[:mines_around].zero?
                                     board_format[:clear_cell]
                                   else
                                     emoji_numbers[tile[:mines_around]]
                                   end
    end
  end
end
