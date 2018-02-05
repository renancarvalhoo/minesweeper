require 'spec_helper'
 
describe Minesweeper::Game do
 
before :each do
    @board = Minesweeper::Game.new(5,5,5)
end

describe "#new" do
    it "takes three parameters and returns a Game object" do
        expect(@board).to be_an_instance_of Minesweeper::Game
    end
end

end
