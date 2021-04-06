class Computer
  attr_reader :board, :ships
  def initialize(board)
    @board = board
    @ships = []
  end

  def cruiser_cell_generator
    @board.cells.keys.combination(3).to_a.shuffle
  end

  def submarine_cell_generator
    @board.cells.keys.combination(2).to_a.shuffle
  end

  # def created_ship_cell_generator
  #   @board.cells.keys.combination(created_ship_length).to_a.shuffle
  # end

  def computer_place
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    # created_ship = Ship.new(created_ship_name, created_ship_length)
    @board.cell_creator
    valid_cruiser = cruiser_cell_generator.find do |array|
      @board.valid_placement?(cruiser, array)
    end
    @board.place(cruiser, valid_cruiser)
    valid_submarine = submarine_cell_generator.find do |array|
      @board.valid_placement?(submarine, array)
    end
    @board.place(submarine, valid_submarine)
    # valid_created_ship = created_ship_cell_generator.find do |array|
    #   @board.valid_placement?(created_ship, array)
    # end
    # @board.place(created_ship, valid_created_ship)
  end

  # def computer_shot
  #   possible_cells = player_board.cells.values
  #   unfired = possible_cells.select do |cell|
  #     cell.fired_upon? == false
  #   end
  #   unfired.shuffle!
  #   shot = unfired.shift.coordinate
  #   puts
  #   puts "COMPUTER ----'I shoot at #{shot}!'"
  #   player_board.fire(shot)
  #   puts "\n"
  #   @board
  #   puts
  # end



end
