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

    def render(show_ships = nil)
      if show_ships == true && empty? == false && sunk? == false
        "S"
      elsif show_ships == true && empty? == false && sunk?
        "X"
      elsif show_ships == true && empty? == false && hit?
        "H"
      elsif blank?
        "."
      elsif miss?
        "M"
      elsif sunk?
        "X"
      elsif hit?
        "H"
      end
    end

  private
    def miss?
      fired_upon? == true && empty? == true
    end

    def hit?
      fired_upon? == true && empty? == false
    end

    def blank?
      fired_upon? == false
    end

    def sunk?
      fired_upon? == true && ship.sunk? == true
    end



end
