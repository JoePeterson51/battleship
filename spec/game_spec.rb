require './lib/board'
require './lib/ship'
require './lib/game'


describe Game do
  it 'exists' do
    game = Game.new

    expect(game).to be_a(Game)
  end

#   it 'has boards' do
#     game = Game.new
#
#     expect(game.computer_board).to be_a(Board)
#     expect(game.player_board).to be_a(Board)
#   end
#
#   xdescribe '#computer_place' do
#     xit 'can place ships' do
#       game = Game.new
#       game.computer_place
#
#       expect(game.computer_board.render(true).include?("S")).to eq(true)
#     end
#
#     xit 'will place both ships' do
#       game = Game.new
#       game.computer_place
#       board = game.computer_board.render(true)
#       split_board = board.split
#       board_select = split_board.select do |string|
#         string == "S"
#       end
#
#       expect(board_select.count).to eq(5)
#     end
#   end
end
