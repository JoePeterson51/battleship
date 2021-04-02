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

  def cruiser_place_greeting
    puts "I have placed my ships!"
    puts "Now it's your turn, punk."
    puts "This is YOUR BOARD!"
  end

  def cruiser_coordinate_prompt
    puts "You have a cruiser. It cruises. Place it. It is 3 units long."
    puts "Enter the squares for the Cruiser. They should be three in a row/column."
    puts "NO DIAGONALS!"
    puts "Enter the first coordinate ->"
  end

  def cruiser_place
    cruiser = Ship.new("Cruiser", 3)
    first_coordinate = gets.chomp.upcase!
    puts "Now enter the second coordinate ->"
    second_coordinate = gets.chomp.upcase!
    puts "Now enter the last coordinate! ->"
    third_coordinate = gets.chomp.upcase!
    cruiser_input = [first_coordinate, second_coordinate, third_coordinate]
      if player_board.valid_placement?(cruiser, cruiser_input) == false
        puts "Those coordinates are not valid!"
        user_place
      else
        player_board.place(cruiser, cruiser_input)
        puts player_board.render(true)
        puts "There it is! Your cruuuuuiser."
      end
  end

  def user_place
    cruiser_place_greeting
    puts player_board.render
    cruiser_coordinate_prompt
    cruiser_place
    user_submarine_place
  end

  def submarine_greeting
    puts "Now place your submarine. Don't place it on your cruiser."
    puts "It is 2 units long."
    puts "Enter your first_coordinate ->"
  end

  def submarine_place
    submarine = Ship.new("Submarine", 2)
    submarine_first_coordinate = gets.chomp.upcase!
    puts "And now the next coordinate. ->"
    submarine_second_coordinate = gets.chomp.upcase!
    submarine_input = [submarine_first_coordinate, submarine_second_coordinate]
      if player_board.valid_placement?(submarine, submarine_input) == false
        puts "Those coordinates are not valid!"
        user_submarine_place
      else
        player_board.place(submarine, submarine_input)
        puts player_board.render(true)
        puts "There it is! Your sub."
      end
  end

  def user_submarine_place
    submarine_greeting
    submarine_place
  end

end
