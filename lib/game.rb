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
    cruiser_cells = @computer_board.cells.keys.combination(3).to_a.shuffle
    submarine_cells = @computer_board.cells.keys.combination(2).to_a.shuffle
    valid_cruiser = cruiser_cells.find do |array|
      @computer_board.valid_placement?(cruiser, array)
    end  
    valid_submarine = submarine_cells.find do |array|
      @computer_board.valid_placement?(submarine, array)
    end 
    @computer_board.place(cruiser, valid_cruiser)
    @computer_board.place(submarine, valid_submarine)
  end 
end 