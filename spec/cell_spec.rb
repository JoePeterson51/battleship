require './lib/ship'
require './lib/cell'

describe Cell do 
    it 'exists' do 
      cell = Cell.new("B4")

      expect(cell).to be_a(Cell)
    end 

    describe '#attr_reader' do 
        it 'has a coordinate' do 
            cell = Cell.new("B4")

            expect(cell.coordinate).to eq("B4")
        end 
    
      
        it 'has no ship' do 
            cell = Cell.new("B4") 

            expect(cell.ship).to eq(nil)
        end 
    end 

    describe '#empty?' do 
        it 'is empty by default' do 
            cell = Cell.new("B4") 

            expect(cell.empty?).to eq(true)
        end 
    end 

    describe '#place_ship' do 
        it 'can place ship' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)

            expect(cell.ship).to eq(cruiser)
        end 

         it 'makes cell not empty' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)

            expect(cell.empty?).to eq(false)
        end 
    end 

    describe '#fired_upon?' do 
        it 'is false by default' do 
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)

            expect(cell.fired_upon?).to eq(false)
        end 
    end 

    describe '#fire_upon' do 
        it 'fire upon changes fired_upon to true' do 
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)
            cell.fire_upon 
        
            expect(cell.fired_upon?).to eq(true)
        end 

        it 'removes health' do 
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)
            cell.fire_upon 

            expect(cell.ship.health).to eq(2)
        end 
    end     

end 