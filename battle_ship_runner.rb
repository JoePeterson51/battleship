require './lib/board'
require './lib/ship'
require './lib/game'
require './lib/turn'
require './lib/cell'


game = Game.new
turn = Turn.new(game)

game.computer_place
game.user_place

turn.turn_start
while turn.has_lost? == false
turn.player_shot
turn.computer_shot
end 
