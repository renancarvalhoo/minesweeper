require 'spec_helper'

describe Minesweeper::Square do
  describe 'ensures ' do
    it 'a new square has no mine when created' do
      square = Minesweeper::Square.new(1, 1)

      expect(square.mine).to be false
    end

    it 'a new square has no flag when created' do
      square = Minesweeper::Square.new(1, 1)

      expect(square.flagged).to be false
    end

    it 'a new square is not revealed when created' do
      square = Minesweeper::Square.new(1, 1)

      expect(square.chosen).to be false
    end

  end

  describe 'returns' do
    it 'the coordinates x and y from a square' do
      square = Minesweeper::Square.new(2, 3)

      expect(square.coordinates).to eq(x: 2, y: 3)
    end

    it 'the coordinates x, y, and mines near from a square when it is revealed' do
      square = Minesweeper::Square.new(2, 3)
      square.choose

      expect(square.coordinates).to eq(x: 2, y: 3, mines_around: 0)
    end

    it 'only the coordinates x and y from a square with mine when it is revealed' do
      square = Minesweeper::Square.new(2, 3)
      square.choose
      square.plant_mine

      expect(square.coordinates).to eq(x: 2, y: 3)
    end
  end
end
