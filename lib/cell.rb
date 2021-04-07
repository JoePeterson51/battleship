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
        if fired_upon?
          return "Already fired here"
        end
        @fired_upon = true
        if empty? == false
            ship.hit
        end
    end

    def render(show_ships = nil)
      if show_ships == true && (empty? == false && sunk?)
        "🏊‍♀️"
      elsif show_ships == true && (empty? == false && hit?)
        "🔥"
      elsif show_ships == true && (empty? == false && sunk? == false)
        "🛳 "
      elsif blank?
        "🌊"
      elsif miss?
        "⭕️"
      elsif sunk?
        "🏊‍♀️"
      elsif hit?
        "🔥"
      end
    end

    def miss?
      fired_upon? && empty?
    end

    def hit?
      fired_upon? && empty? == false
    end

    def blank?
      fired_upon? == false
    end

    def sunk?
      fired_upon? && ship.sunk?
    end


end
