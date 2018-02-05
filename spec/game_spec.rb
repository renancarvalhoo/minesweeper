require 'spec_helper'
require 'pry'

describe Minesweeper::Game do

  before :each do
    @game = Minesweeper::Game.new(5,5,5)
  end

  describe "#new" do
    it "takes three parameters and returns a Game object" do
      expect(@game).to be_an_instance_of Minesweeper::Game
    end
  end

  describe 'shows ' do
    it 'the board state' do
      game = Minesweeper::Game.new(2, 2, 0)
      expect(%i[not_chosen exploded chosen flagged board_configuration]).to eq(game.board_state.keys)

      expect(4).to eq(game.board_state[:not_chosen].size)
    end

    it 'all mines in the board state with option xray when finishes the game' do
      game = Minesweeper::Game.new(2, 2, 2)

      tile = game.board.squares.select(&:mine).first
      game.play(x: tile.coordinates[:x] + 1, y: tile.coordinates[:y] + 1)

      expect(game.still_playing?).to be false
      expect(%i[not_chosen exploded chosen flagged all_mines board_configuration]).to eq(game.board_state(show_mines: true).keys)
    end
  end



  describe 'plays ' do
    it 'a tile and expand all the squares without mines' do
      game = Minesweeper::Game.new(3, 3, 0)

      expect(0).to eq(game.board_state[:chosen].size)

      game.play(x: 1, y: 1)
      expect(9).to eq(game.board_state[:chosen].size)
    end
  end

  describe 'plays ' do
    it 'a tile and not expand when the near tile has a mine' do
      game = Minesweeper::Game.new(2, 2, 1)

      tile = game.board.squares.reject(&:mine).first
      game.play(x: tile.coordinates[:x] + 1, y: tile.coordinates[:y] + 1)

      expect(1).to eq(game.board_state[:chosen].size)
    end
  end

  describe 'flags' do
    it 'a tile and see the effect on the board state' do
      game = Minesweeper::Game.new(2, 2, 0)

      expect(0).to eq(game.board_state[:flagged].size)

      expect(game.flag(x: 1, y: 1)).to be true
      expect(1).to eq(game.board_state[:flagged].size)

      coordinate = { x: 0, y: 0 }
      expect(coordinate).to eq(game.board_state[:flagged].first)
    end
  end

  describe 'removes' do
    it 'a flag from a tile flagged' do
      game = Minesweeper::Game.new(2, 2, 0)

      expect(game.flag(x: 1, y: 1)).to be true
      expect(1).to eq(game.board_state[:flagged].size)

      expect(game.flag(x: 1, y: 1)).to be true
      expect(0).to eq(game.board_state[:flagged].size)
    end
  end

  describe 'is playing' do
    it ' when game starts and no action was taken' do
      game = Minesweeper::Game.new(2, 2, 2)
      expect(game.victory?).to be false
      expect(game.still_playing?).to be true
    end
  end

  describe 'finishes' do
    it ' the game when when revealed all the squares' do
      game = Minesweeper::Game.new(1, 1, 0)

      game.play(x: 1, y: 1)

      expect(game.still_playing?).to be false
      expect(game.victory?).to be true
    end
  end

  describe 'loses when you reveal a mine' do
    it 'loses when you reveal a mine' do
      game = Minesweeper::Game.new(2, 2, 1)

      tile = game.board.squares.select(&:mine).first
      game.play(x: tile.coordinates[:x] + 1, y: tile.coordinates[:y] + 1)

      expect(game.victory?).to be false
      expect(game.still_playing?).to be false
    end
  end

  describe 'denies' do
    it 'the actions play and flag after reveal a mine' do
      game = Minesweeper::Game.new(2, 2, 1)

      tile = game.board.squares.select(&:mine).first

      expect(game.play(x: tile.coordinates[:x] + 1, y: tile.coordinates[:y] + 1)).to be true
      expect(game.victory?).to be false
      expect(game.still_playing?).to be false

      tile = game.board.squares.reject(&:mine).first
      expect(game.play(x: tile.coordinates[:x] + 1, y: tile.coordinates[:y] + 1)).to be false
      expect(game.flag(x: tile.coordinates[:x] + 1, y: tile.coordinates[:y] + 1)).to be false
    end
  end

  describe 'stills playing ' do
    it 'when you flag more squares than mines' do
      game = Minesweeper::Game.new(2, 2, 1)

      game.flag(x: 1, y: 1)
      game.flag(x: 1, y: 2)
      game.flag(x: 2, y: 2)
      game.flag(x: 2, y: 2)

      expect(game.victory?).to be false
      expect(game.still_playing?).to be true
    end
  end

  describe 'show existing ' do
    it 'near mines from squares chosen' do
      game = Minesweeper::Game.new(2, 2, 2)

      tile = game.board.squares.reject(&:mine).first
      game.play(x: tile.coordinates[:x] + 1, y: tile.coordinates[:y] + 1)

      tile = game.board_state[:chosen].first
      expect(2).to eq(tile[:mines_around])
    end
  end

end
