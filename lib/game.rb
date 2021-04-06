class Game
  attr_reader :computer_board, :player_board, :game_over, :created_ship_name, :created_ship_length
  def initialize
    @computer_board = computer_board
    @player_board = player_board
    @created_ship_name = created_ship_name
    @created_ship_length = created_ship_length
    @game_over = false
  end

  def welcome_message
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Welcome to BATTLESHIP!!!!"
    puts "Enter (P) to play. Enter (Q) to quit."
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def welcome
    welcome_message
    input = gets.chomp.upcase!
    puts
    if input == "P"
      start
    elsif input == "Q"
      puts "Goodbye!"
    else
      puts "Invalid input"
      puts
      welcome
    end
  end

  def start
    puts "How big should the board be? Enter a number between 1-26."
    board_length = gets.chomp
    @player_board = Board.new(board_length)
    @computer_board = Board.new(board_length)
    user_place
    computer_place
    loop do
      player_shot
      if game_over?
        puts "game over"
        puts "\n"
        welcome
      break
      end
    computer_shot
      if game_over?
        puts "game over"
        puts "\n"
        welcome
      break
      end
    end
  end

  def cruiser_cell_generator
    @computer_board.cells.keys.combination(3).to_a.shuffle
  end

  def submarine_cell_generator
    @computer_board.cells.keys.combination(2).to_a.shuffle
  end

  def created_ship_cell_generator
    @computer_board.cells.keys.combination(created_ship_length).to_a.shuffle
  end

  def computer_place
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    created_ship = Ship.new(created_ship_name, created_ship_length)
    computer_board.cell_creator
    valid_cruiser = cruiser_cell_generator.find do |array|
      @computer_board.valid_placement?(cruiser, array)
    end
    @computer_board.place(cruiser, valid_cruiser)
    valid_submarine = submarine_cell_generator.find do |array|
      @computer_board.valid_placement?(submarine, array)
    end
    @computer_board.place(submarine, valid_submarine)
    valid_created_ship = created_ship_cell_generator.find do |array|
      @computer_board.valid_placement?(created_ship, array)
    end
    @computer_board.place(created_ship, valid_created_ship)
  end

  # def cruiser_place_greeting
  #   puts "I have placed my ships!"
  #   puts "Now it's your turn, punk."
  #   puts "This is YOUR BOARD!"
  #   puts "-------------------------"
  # end

  # def cruiser_coordinate_prompt
  #   puts "You have a cruiser. It cruises. Place it. It is 3 units long."
  #   puts "Enter the squares for the Cruiser. They should be three in a row/column."
  #   puts "NO DIAGONALS!"
  #   puts
  #   puts "Enter the first coordinate ->"
  # end

  def cruiser_place
    cruiser = Ship.new("Cruiser", 3)
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

  def user_place
    cruiser_place_greeting
    puts player_board.render
    puts
    cruiser_coordinate_prompt
    cruiser_place
    user_submarine_place
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
    submarine_first_coordinate = gets.chomp.upcase!
    puts
    puts "And now the next coordinate. ->"
    submarine_second_coordinate = gets.chomp.upcase!
    puts "-------------------------------"
    submarine_input = [submarine_first_coordinate, submarine_second_coordinate]
      if player_board.valid_placement?(submarine, submarine_input) == false
        puts "Those coordinates are not valid!"
        puts
        user_submarine_place
      else
        player_board.place(submarine, submarine_input)
        puts player_board.render(true)
        puts
        puts "^^^ There it is! Your sub."
        puts "-------------------------------"
        puts
      end
      create_ship
    end

    def create_ship
      puts "Now create your own ship!"
      puts
      puts "Enter ship name"
      name = gets.chomp.capitalize
      puts "Enter ship length 2-5"
      length = gets.chomp.to_i
      ship = Ship.new(name, length)
      input_count = 1
      input = []
      length.times do
        puts "Enter coordinate ##{input_count}"
        input << gets.chomp.upcase!
        input_count += 1
      end
      if player_board.valid_placement?(ship, input) == false
          puts "Those coordinates are not valid!"
          puts
          create_ship
        else
          player_board.place(ship, input)
          puts player_board.render(true)
          puts
          puts "^^^ There it is! Your #{name}."
          puts "-------------------------------"
          puts
        end
        @created_ship_name = name
        @created_ship_length = length
    end

  def user_submarine_place
    submarine_greeting
    submarine_place
  end

  def prompt_shot
    puts "Enter your coordinate for your shot!!"
  end

  def show_computer_board
    puts "==========COMPUTER BOARD=========="
    puts computer_board.render
    puts "=================================="
  end

  def show_player_board
    puts "==========PLAYER BOARD=========="
    puts player_board.render(true)
    puts "================================"
  end

  def player_ships
    player_board.cells.select do |coordinate, cell|
      cell.ship != nil
    end
  end

  def computer_ships
    computer_board.cells.select do |coordinate, cell|
      cell.ship != nil
    end
  end

  def player_alive?
    player_ships.any? do |coordinate, cell|
      cell.ship.sunk? == false
    end
  end

  def computer_alive?
    computer_ships.any? do |coordinate, cell|
      cell.ship.sunk? == false
    end
  end

  def game_over_message
    if player_alive? == false
      puts "Computer won."
    elsif computer_alive? == false
      puts "YOU WON!!!!!!"
    end
  end

  def game_over?
    if player_alive? == false
      @game_over = true
      game_over_message
    elsif computer_alive? == false
      @game_over = true
      game_over_message
    else
      @game_over = false
    end
    @game_over
  end

  def player_shot
    prompt_shot
    shot = gets.chomp.upcase!
    if computer_board.valid_coordinate?(shot) && computer_board.cells[shot].fired_upon?
      puts
      puts "!!!Already fired here!!!"
      puts "------------------------"
      player_shot
    elsif computer_board.valid_coordinate?(shot) && computer_board.cells[shot].fired_upon? == false
      computer_board.fire(shot)
    else
      puts
      puts "That's an invalid coordinate. What are you doing?"
      puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      player_shot
    end
    puts
    show_computer_board
  end

  def computer_shot
    possible_cells = player_board.cells.values
    unfired = possible_cells.select do |cell|
      cell.fired_upon? == false
    end
    unfired.shuffle!
    shot = unfired.shift.coordinate
    puts
    puts "COMPUTER ----'I shoot at #{shot}!'"
    player_board.fire(shot)
    puts "\n"
    @computer_board
    show_player_board
    puts
  end
end
