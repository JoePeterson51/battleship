require './lib/board'
require './lib/ship'
require 'pry'

describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_a(Board)
  end

  it 'has a cell' do
    board = Board.new

    expect(board.cells).to be_a(Hash)

  end

  it 'has another cell' do
    board = Board.new

    expect(board.cells["D4"]).to be_a(Cell)
  end

  describe "#valid_coordinate?" do
    it "returns true for valid" do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
    end

    it "returns false for invalid" do
      board = Board.new

      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("D5")).to eq(false)
    end
  end

  describe "#valid_placement?" do
    it "returns false for invalid inputs" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A5", "A2"])).to eq(false)
    end

    it "returns false for invalid cell count" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    end

    it 'number must be consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    end

    it 'letters must be consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A1", "C1", "D1"])).to eq(false)
    end

    it 'number must increment' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    end

    it 'letters must increment' do
      board = Board.new
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    end 



#Next make sure coordinates are consecutive
#Learn about branching and make a new branch.


    # it "returns true for valid" do
    #   board = Board.new
    #   cruiser = Ship.new("Cruiser", 3)
    #   submarine = Ship.new("Submarine", 2)
    #
    #   expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq(true)
    # end

  end
end
