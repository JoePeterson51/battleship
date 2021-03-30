
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

  def cell_compare?(cells_array)
    cells_split = cells_array.map do |cell|
      cell.split('')
    end 
    first_element = cells_split.map do |array|
      array[0]
    end 
    letter_coordinate = first_element.uniq.length == 1
    second_element = cells_split.map do |array|
      array[1].to_i
    end 
    number_coordinate = second_element.each_cons(2).all? do |x, y|
      y == x + 1
    end 
    return false if letter_coordinate == false 
    return false if number_coordinate == false 
    true 
  end 

  def valid_placement?(ship, cells_array)
      return false if cells_array.any? do |coordinate|
        valid_coordinate?(coordinate) == false
                end
      return false if cells_array.count != ship.length
      cell_compare?(cells_array)
      # true
  end



  #   else
  #     return true
  #   end
  # end

end
