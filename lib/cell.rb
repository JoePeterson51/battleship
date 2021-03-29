class Cell 
    attr_reader :coordinate, :ship
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = ship 
        @fired_upon = false
    end 

    def empty? 
      @ship == nil 
    end 

    def place_ship(ship)
        return false if empty? == false 
        @ship = ship 
    end 

    def fired_upon?
        @fired_upon
    end 

    def fire_upon
        return "already fired here" if fired_upon? == true 
        @fired_upon = true 
        if empty? == false 
            ship.hit 
        end 
    end 

    def render
        if fired_upon? == false 
            "."
        elsif fired_upon? == true && empty? == true 
            "M"
        elsif fired_upon? == true && ship.sunk? == true 
            "X"
        elsif fired_upon? == true && empty? == false 
            "H"
        end 
    end 
end 