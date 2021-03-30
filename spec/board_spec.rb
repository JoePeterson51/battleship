require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_a(Board)
  end

end
