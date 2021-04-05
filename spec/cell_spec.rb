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
            expect(cell.fire_upon).to eq("Already fired here")
        end
    end

    describe '#render' do
        it 'renders empty space' do
            cell_1 = Cell.new("B4")

            expect(cell_1.render).to eq(".")
        end

        it 'render a miss space' do
            cell_1 = Cell.new("B4")
            cell_1.fire_upon

            expect(cell_1.render).to eq("M")
        end

        it 'renders sunk space' do
            cell_1 = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 1)
            cell_1.place_ship(cruiser)
            cell_1.fire_upon

            expect(cell_1.render).to eq("X")
        end

        it 'renders hit space' do
            cell_1 = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell_1.place_ship(cruiser)
            cell_1.fire_upon

            expect(cell_1.render).to eq("H")
        end

        it 'renders show ship space' do
            cell_1 = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell_1.place_ship(cruiser)


            expect(cell_1.render(true)).to eq("S")
        end
    end

    describe 'multi cell edge case' do
        it 'can work with multi cells' do
            cell_1 = Cell.new("B4")
            cell_2 = Cell.new("B5")
            cell_3 = Cell.new("B6")
            cruiser = Ship.new("Cruiser", 2)
            cell_1.place_ship(cruiser)
            cell_2.place_ship(cruiser)
            cell_3.fire_upon

            expect(cell_3.render).to eq("M")
            expect(cell_2.render(true)).to eq("S")
            expect(cell_1.render).to eq(".")

            cell_1.fire_upon
            expect(cell_1.render).to eq("H")

            cell_2.fire_upon
            expect(cell_1.render).to eq("X")
            expect(cell_2.render).to eq("X")
        end
    end

end
