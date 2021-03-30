require './lib/ship'
require 'pry'


describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_a(Ship)
  end

  describe '#attr_reader' do
    it 'has a name' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.name).to eq("Cruiser")
    end

    it 'has a length' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.length).to eq(3)
    end

    it 'has health equal to length' do
      cruiser = Ship.new("Cruiser", 3)
     
      expect(cruiser.health).to eq(3)
    end
  end

  describe "#sunk?" do
    it 'has not sunk yet' do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.sunk?).to eq(false)
    end
  end

  describe "#hit" do
    it 'decreases health when called' do
        cruiser = Ship.new("Cruiser", 3)

        expect(cruiser.health).to eq(3)
        cruiser.hit
        expect(cruiser.health).to eq(2)
        cruiser.hit
        expect(cruiser.health).to eq(1)
    end

    it 'can sink a ship' do
        cruiser = Ship.new("Cruiser", 3)

        expect(cruiser.health).to eq(3)
        cruiser.hit
        expect(cruiser.health).to eq(2)
        cruiser.hit
        expect(cruiser.health).to eq(1)
        expect(cruiser.sunk?).to eq(false)
        cruiser.hit
        expect(cruiser.sunk?).to eq(true)
    end
  end

end
