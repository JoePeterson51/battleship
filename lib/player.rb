class Player
  attr_reader :board, :ships
  def initialize(board)
    @board = board
    @ships = []
  end

  def cruiser_place_greeting
    puts "I have placed my ships!"
    puts "Now it's your turn, punk."
    puts "This is YOUR BOARD!"
    puts "-------------------------"
  end

  def cruiser_coordinate_prompt
    puts "You have a cruiser. It cruises. Place it. It is 3 units long."
    puts "Enter the squares for the Cruiser. They should be three in a row/column."
    puts "NO DIAGONALS!"
    puts
    puts "Enter the first coordinate ->"
  end

  def add_ship(ship)
    @ships << ship
  end

  def cruiser_place
    cruiser = Ship.new("Cruiser", 3)
    add_ship(cruiser)
    first_coordinate = gets.chomp.upcase!
    puts
    puts "Now enter the second coordinate ->"
    second_coordinate = gets.chomp.upcase!
    puts
    puts "Now enter the last coordinate! ->"
    third_coordinate = gets.chomp.upcase!
    puts "----------------------------------"
    cruiser_input = [first_coordinate, second_coordinate, third_coordinate]
      if player_board.valid_placement?(cruiser, cruiser_input) == false
        puts "Those coordinates are not valid!"
        puts
        user_place
      else
        player_board.place(cruiser, cruiser_input)
        puts player_board.render(true)
        puts
        puts "^^^ There it is! Your cruuuuuiser."
        puts "----------------------------------"
      end
  end

end
