
class Board

  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
          }
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
    elsif increment?(letter_coordinate) == true
        return false if one_element?(number_coordinate) == false
    elsif increment?(number_coordinate) == true
        return false if one_element?(letter_coordinate) == false
    else
      true
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
end
