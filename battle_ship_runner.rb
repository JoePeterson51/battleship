require './lib/board'
require './lib/ship'
require './lib/game'
require './lib/turn'
require './lib/cell'


game = Game.new

game.computer_place
game.user_place

puts game.computer_board.render
puts game.player_board.render
