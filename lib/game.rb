class Game 
  attr_reader :computer_board, :player_board
  def initialize
    @computer_board = Board.new 
    @player_board = Board.new 
  end 

  def welcome 
    p "Welcome to BATTLESHIP!!!!"
    p "Enter (P) to play. Enter (Q) to quit."
    input = gets.chomp.upcase
    if input == "P"
      start 
    elsif input == "Q"
      puts "Goodbye!"
    else 
      puts "Invalid input"
    end 
  end 
 
  

  def computer_place
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    computer_board.cell_creator
    cells_arr = @computer_board.cells.keys.sample(3)
    until @computer_board.valid_placement?(cruiser, cells_array) == true 
      @computer_board.place(cruiser, cells_array) 
    end 
    require 'pry'; binding.pry
  end 
end 