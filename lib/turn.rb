class Turn 
  attr_reader :game 
  def initialize(game)
    @game = game 
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
    if game.computer_board.valid_coordinate?(shot) 
      game.computer_board.fire(shot)
    else
      puts "Invalid coordinate. Try again."
      player_shot
    end 
    puts game.computer_board.render 
  end 

  
end 