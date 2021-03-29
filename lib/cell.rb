class Cell 
    attr_reader :coordinate, :ship
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = ship 
    end 

    def empty? 
      true
    end 

    def place_ship(ship)
        return false if empty? == false 
        @ship = ship 
    end 
end 