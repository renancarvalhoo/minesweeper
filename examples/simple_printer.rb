class SimplePrinter
  attr_reader :board_state, :board, :board_format

  def set_format(option)
    @board_format = option
  end

  def board_format
    @board_format ||= {
      unknown_cell: '.',
      clear_cell: ' ',
      mine: '#',
      flag: 'f'
    }
  end

  def print(board_state)
    board_configuration = board_state.fetch(:board_configuration)
    rows = board_configuration.fetch(:width)
    columns = board_configuration.fetch(:height)

    build_board(rows, columns, board_state)

    puts Kernel.print '|', '-' * columns, '|'
    @board.each do |row|
      puts Kernel.print '|', row.join, '|'
    end
    puts Kernel.print '|', '-' * columns, '|'
  end

  private

  def build_board(rows, columns, board_state)
    @board = Array.new(rows) { Array.new(columns) { board_format[:unknown_cell] } }

    populate_exploded_mine(board_state[:exploded])
    populate_revealed_tile(board_state[:chosen])
    populate_flagged_tile(board_state[:flagged])
    populate_mines_not_found(board_state[:all_mines] || [])
  end

  def populate_exploded_mine(tiles)
    tiles.each do |tile|
      @board[tile[:x]][tile[:y]] = board_format[:mine]
    end
  end

  def populate_revealed_tile(tiles)
    tiles.each do |tile|
      @board[tile[:x]][tile[:y]] = if tile[:mines_around].zero?
                                     board_format[:clear_cell]
                                   else
                                     tile[:mines_around].to_s
                                   end
    end
  end

  def populate_flagged_tile(tiles)
    tiles.each do |tile|
      @board[tile[:x]][tile[:y]] = board_format[:flag]
    end
  end

  def populate_mines_not_found(tiles)
    tiles.each do |tile|
      @board[tile[:x]][tile[:y]] = board_format[:mine]
    end
  end
end
