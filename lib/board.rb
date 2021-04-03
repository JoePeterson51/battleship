
class Board

  attr_reader :cells
  def initialize
    @cells = cell_creator
  end

  def cell_creator
    letters = ["A", "B", "C", "D"]
    numbers = ["1", "2", "3", "4"]
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
    cells_split = cells_array.map do |cell|
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
    rendered = @cells.map do |location, cell |
        cell.render(show_ships)
    end
    rendered << "\n"
    rendered.insert(12, "\nD")
    rendered.insert(8, "\nC")
    rendered.insert(4, "\nB")
    rendered.unshift("  1 2 3 4 \nA")
    rendered.join(" ")
  end

  def fire(cell)
    fired_cell = @cells[cell]
    fired_cell.fire_upon
    shot_evaluate(fired_cell)

    # fired_cell.shot_evaluate

  end

  def shot_evaluate(cell)

    if cell.miss?
      p "You missed!"
      puts "\n"
    elsif cell.sunk?
      p "You sunk the ship!"
      puts "\n"
    elsif cell.hit?
      p "You hit a ship!"
      puts "\n"
    end
  end


end
