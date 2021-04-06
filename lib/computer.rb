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

  def add_ship(ship)
    @ships << ship
  end

  # def created_ship_cell_generator
  #   @board.cells.keys.combination(created_ship_length).to_a.shuffle
  # end

  def computer_place
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    add_ship(cruiser)
    add_ship(submarine)
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
end
