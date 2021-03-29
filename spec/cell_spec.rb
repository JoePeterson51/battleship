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

end 