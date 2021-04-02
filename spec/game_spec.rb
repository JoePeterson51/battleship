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

    expect(game.computer_board).to be_a(Board)
    expect(game.player_board).to be_a(Board)
  end 

  describe '#computer_place' do 
    it 'can place ships' do 
      game = Game.new 
      game.computer_place

      expect(game.computer_board.render(true).include?("S")).to eq(true)
    end
    
    it 'will place both ships' do 
      game = Game.new 
      game.computer_place
      s = game.computer_board.render(true)
      a = s.split
      b = a.select do |string|
        string == "S"
      end 
      expect(b.count).to eq(5)
    end 
  end  
end 

