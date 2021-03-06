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
    cruiser_place_greeting
    puts board.render
    puts
    cruiser_coordinate_prompt
    first_coordinate = gets.chomp.upcase!
    puts
    puts "Now enter the second coordinate ->"
    second_coordinate = gets.chomp.upcase!
    puts
    puts "Now enter the last coordinate! ->"
    third_coordinate = gets.chomp.upcase!
    puts "----------------------------------"
    cruiser_input = [first_coordinate, second_coordinate, third_coordinate]
      if board.valid_placement?(cruiser, cruiser_input) == false
        puts "Those coordinates are not valid!"
        puts
        user_place
      else
        board.place(cruiser, cruiser_input)
        puts board.render(true)
        puts
        puts "^^^ There it is! Your cruuuuuiser."
        puts "----------------------------------"
      end
  end

  def user_place
    cruiser_place
    user_submarine_place
    place_created_ship
  end

  def user_submarine_place
    submarine_greeting
    submarine_place
  end

  def prompt_shot
    puts "Enter your coordinate for your shot!!"
  end

  def submarine_greeting
    puts
    puts "Now place your submarine. Don't place it on your cruiser."
    puts "It is 2 units long."
    puts
    puts "Enter your first_coordinate ->"
  end

  def submarine_place
    submarine = Ship.new("Submarine", 2)
    add_ship(submarine)
    submarine_first_coordinate = gets.chomp.upcase!
    puts
    puts "And now the next coordinate. ->"
    submarine_second_coordinate = gets.chomp.upcase!
    puts "-------------------------------"
    submarine_input = [submarine_first_coordinate, submarine_second_coordinate]
    if board.valid_placement?(submarine, submarine_input) == false
      puts "Those coordinates are not valid!"
      puts
      user_submarine_place
    else
      board.place(submarine, submarine_input)
      puts board.render(true)
      puts
      puts "^^^ There it is! Your sub."
      puts "-------------------------------"
      puts
    end
  end

  def place_created_ship
    length = @ships.first.length 
    name = @ships.first.name 
    puts "This is your #{name}."
    puts 
    puts "It is #{length} units long."
    input_count = 1
    input = []
    length.times do
    puts "Enter coordinate ##{input_count}"
    input << gets.chomp.upcase!
    input_count += 1
    end
    if board.valid_placement?(@ships.first, input) == false
      puts "Those coordinates are not valid!"
      puts
      place_created_ship
    else
      board.place(@ships.first, input)
      puts board.render(true)
      puts
      puts "^^^ There it is! Your #{name}."
      puts "-------------------------------"
      puts
    end
  end
end 
