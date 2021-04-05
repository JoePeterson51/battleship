
class Board

  attr_reader :cells, :board_length, :potential_letters
  def initialize (board_length)
    @board_length = board_length.to_i
    @potential_letters = ('A'..'Z').to_a
    @cells = cell_creator
  end

  def cell_creator
    letters = @potential_letters[0..(@board_length - 1)]
    numbers = letters.map do |letter|
       (letters.index(letter) + 1).to_s
    end
    cells = {}
    coordinates = letters.map do |letter|
    letter = numbers.map do |coordinate|
          letter + coordinate
      end
    end.flatten
    coordinates.map do |coordinate|
     cells[coordinate] = Cell.new(coordinate)
    end
    cells
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def cells_split(cells_array)
    cells_array.map do |cell|
      cell.split('')
    end
  end

  def increment?(coordinate)
    coordinate.each_cons(2).all? do |x, y|
      y == x + 1
    end
  end

  def one_element?(coordinate)
    coordinate.uniq.count == 1
  end

  def equal_length(ship, cells_array)
    cells_array.count == ship.length
  end

  def valid_placement?(ship, cells_array)
    return false if cells_array.any? do |coordinate|
      valid_coordinate?(coordinate) == false
    end
    return false if equal_length(ship, cells_array) == false
    letter_coordinate = cells_split(cells_array).map do |array|
      array[0].ord
    end
    number_coordinate = cells_split(cells_array).map do |array|
      array[1].to_i
    end
    placed_cells = cells_array.map do |cell|
      @cells[cell]
    end
    return false if placed_cells.any? do |cell|
      cell.empty? == false
    end
    if one_element?(letter_coordinate)
      increment?(number_coordinate)
    elsif one_element?(number_coordinate)
      increment?(letter_coordinate)
    elsif increment?(letter_coordinate)
       one_element?(number_coordinate)
    elsif increment?(number_coordinate)
      one_element?(letter_coordinate)
    end
  end

  def place(ship, cells_array)
    return false if valid_placement?(ship, cells_array) == false
    placed_cells = cells_array.map do |cell|
      @cells[cell]
    end
    placed_cells.map do |cell|
      cell.place_ship(ship)
    end
  end

  def render(show_ships = nil)
    format_render(show_ships)
  end

  def format_render(show_ships = nil)
    letters = @potential_letters[0..(@board_length - 1)]
    numbers = letters.map do |letter|
      (letters.index(letter) + 1).to_s 
    end 
    coordinates = letters.map do |letter|
      letter = numbers.map do |number|
        letter + number 
      end 
    end.flatten
    puts "     " + numbers.join("      ")

    rendered_cells = cells.map do |coordinate, cell|
      cell
    end 

    cell_hash = Hash.new do |hash, key|
      hash[key] = []
    end 

    letters.each do |letter| 
      cell_hash[letter] = [] 
    end 

    rendered_cells.map do |cell|
      cell_hash.map do |key, value|
        if cell.coordinate[0] == key 
          cell_hash[key] << cell 
        end 
      end 
    end 

    cell_hash.map do |letter, cells|
      cell_hash[letter] = cells.map do |cell|
        cell.render(show_ships)
      end 
    end 

    rendered_cells_hash = cell_hash.map do |letter, cells|
      puts "\n #{letter}   " + cells.join("      ")
    end 
  end

  def fire(cell)
    fired_cell = @cells[cell]
    fired_cell.fire_upon
    shot_evaluate(fired_cell)
  end

  def shot_evaluate(cell)
    if cell.miss?
      puts
      p "#{cell.coordinate} missed!"
    elsif cell.sunk?
      puts
      p "#{cell.coordinate} sunk the ship!"
    elsif cell.hit?
      puts
      p "#{cell.coordinate} hit a ship!"
    end
  end
end
