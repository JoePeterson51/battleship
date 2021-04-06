class Game
  attr_reader :computer_board,
              :player_board,
              :game_over,
              :created_ship_name,
              :created_ship_length,
              :player,
              :computer
  def initialize
    @computer_board = computer_board
    @player_board = player_board
    @player = player
    @computer = computer
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
    @player = Player.new(@player_board)
    @computer = Computer.new(@computer_board)
    player.user_place
    computer.computer_place
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

  # def created_ship_cell_generator
  #   @computer_board.cells.keys.combination(created_ship_length).to_a.shuffle
  # end
  
  # def create_ship
  #   puts "Now create your own ship!"
  #   puts
  #   puts "Enter ship name"
  #   name = gets.chomp.capitalize
  #   puts "Enter ship length 2-5"
  #   length = gets.chomp.to_i
  #   ship = Ship.new(name, length)
  #   input_count = 1
  #   input = []
  #   length.times do
  #     puts "Enter coordinate ##{input_count}"
  #     input << gets.chomp.upcase!
  #     input_count += 1
  #   end
  #   if player_board.valid_placement?(ship, input) == false
  #       puts "Those coordinates are not valid!"
  #       puts
  #       create_ship
  #     else
  #       player_board.place(ship, input)
  #       puts player_board.render(true)
  #       puts
  #       puts "^^^ There it is! Your #{name}."
  #       puts "-------------------------------"
  #       puts
  #     end
  #     @created_ship_name = name
  #     @created_ship_length = length
  # end

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

  def player_dead?
    player.ships.all? do |ship|
      ship.health == 0
    end 
  end 

  def computer_dead?
    computer.ships.all? do |ship|
      ship.health == 0
    end 
  end 
  
  def game_over?
    if player_dead?
      @game_over = true
      game_over_message
    elsif computer_dead?
      @game_over = true
      game_over_message
    else
      @game_over = false
    end
    @game_over
  end


  def game_over_message
    if player_dead?
      puts "Computer won."
    elsif computer_dead?
      puts "YOU WON!!!!!!"
    end
  end

  def player_shot
    player.prompt_shot
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
