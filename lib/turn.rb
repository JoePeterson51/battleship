class Turn
  attr_reader :game, :game_over
  def initialize(game)
    @game = game
    @game_over = false 
  end


  def turn_start
    puts "==========COMPUTER BOARD=========="
    puts game.computer_board.render
    puts "==========PLAYER BOARD=========="
    puts game.player_board.render(true)
  end

  def prompt_shot
    puts "Enter your coordinate for your shot!!"
  end

  def player_shot
    prompt_shot
    shot = gets.chomp.upcase!
    if game.computer_board.valid_coordinate?(shot) && game.computer_board.cells[shot].fired_upon? == false
      game.computer_board.fire(shot)
    else
      puts "Invalid coordinate. Try again."
      player_shot
    end
    puts game.computer_board.render
  end

  def computer_shot
    possible_cells = game.player_board.cells.values
    unfired = possible_cells.select do |cell|
      cell.fired_upon? == false
    end
    unfired.shuffle!
    shot = unfired.shift.coordinate
    game.player_board.fire(shot)
    puts "I shoot at #{shot}!"
    puts game.player_board.render(true)
  end

  def game_over?
    if game.player_board.render(true).include?("S") == false
      puts "Computer has won"
      @game_over = true 
    elsif game.computer_board.render(true).include?("S") == false 
      puts "You have won!!!"
      @game_over = true
    end
      @game_over
  end
end
