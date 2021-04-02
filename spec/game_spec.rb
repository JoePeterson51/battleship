require './lib/board'
require './lib/ship'
require './lib/game'
require './lib/turn'

describe Game do
  it 'exists' do 
    game = Game.new

    expect(game).to be_a(Game)
  end 

  it 'has boards' do 
    game = Game.new 

    expect(game.board_1).to be_a(Board)
    expect(game.board_2).to be_a(Board)
  end 

end 

