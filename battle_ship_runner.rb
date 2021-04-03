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

loop do
  turn.player_shot
  turn.computer_shot

if turn.game_over?
  puts "Game over"
  break
end 
end
