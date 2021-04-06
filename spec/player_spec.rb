require './lib/board'
require './lib/ship'
require './lib/game'
require './lib/player'
require './lib/cell'

describe Player do

  it "exists" do
    board = Board.new(4)
    player = Player.new(board)

    expect(player).to be_a(Player)
  end

  it "has a board" do
    board = Board.new(4)
    player = Player.new(board)


    expect(player.board).to be_a(Board)
  end

  it "has no ships to start" do
    board = Board.new(4)
    player = Player.new(board)

    expect(player.ships).to eq([])
  end



  # describe "#cruiser_place" do
  #   it 'can place a cruiser' do
  #     board = Board.new(4)
  #     player = Player.new(board)
  #     player.cruiser_place
  #
  #     expect(player.ships).to eq([cruiser])
  #
  #
  #   end

  end

end
