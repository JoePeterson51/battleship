require './lib/board'
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
end
