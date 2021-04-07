class Game
  attr_reader :computer_board,
              :player_board,
              :game_over,
              :created_ship_name,
              :created_ship_length,
              :player,
              :computer,
              :max_length
  def initialize
    @computer_board = computer_board
    @player_board = player_board
    @player = player
    @computer = computer
    @created_ship_name = created_ship_name
    @created_ship_length = created_ship_length
    @game_over = false
    @max_length = 3
  end

  def welcome_message
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
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
    @max_length = board_length.to_i
    @player_board = Board.new(board_length)
    @computer_board = Board.new(board_length)
    @player = Player.new(@player_board)
    @computer = Computer.new(@computer_board)
    create_ship
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
  
  def create_ship
    puts "Now create your own ship!"
    puts
    puts "Enter ship name"
    name = gets.chomp.capitalize
    puts "Enter ship length 2-5"
    length = gets.chomp.to_i
    if length > @max_length
      puts "That ship is too large!!"
      puts 
      create_ship
    end 
    ship = Ship.new(name, length)
    ship_2 = Ship.new(name, length)
    player.add_ship(ship)
    computer.add_ship(ship_2)
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
