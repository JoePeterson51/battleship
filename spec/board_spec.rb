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
end
