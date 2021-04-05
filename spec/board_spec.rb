require './lib/board'
require './lib/ship'
require 'pry'

describe Board do
  it 'exists' do
    board = Board.new(5)

    expect(board).to be_a(Board)
  end

  it 'has a cell' do
    board = Board.new(5)

    expect(board.cells).to be_a(Hash)
    expect(board.cells.keys[0]).to be_a(String)
    expect(board.cells.values[0]).to be_a(Cell)
  end

  it 'has another cell' do
    board = Board.new(4)


    expect(board.cells["D4"]).to be_a(Cell)
  end

  describe "#valid_coordinate?" do
    it "returns true for valid" do
      board = Board.new(4)

      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
    end

    it "returns false for invalid" do
      board = Board.new(4)

      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("D5")).to eq(false)
    end
  end

  describe "#valid_placement?" do
    it "returns false for invalid inputs" do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A5", "A2"])).to eq(false)
    end

    it "returns false for invalid cell count" do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    end

    it 'number must be consecutive' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    end

    it 'letters must be consecutive' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A1", "C1", "D1"])).to eq(false)
    end

    it 'number must increment' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)

      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    end

    it 'letters must increment' do
      board = Board.new(4)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    end

    it "cant be diagonal" do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
    end

    it "accepts valid inputs" do
      board = Board.new(4)
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
    end
  end

  describe '#place' do
    it 'places ship' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to be_a(Ship)
      expect(cell_3.ship == cell_2.ship).to eq(true)
    end

    it 'wont overlap ships' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
    end
  end

  describe "#render" do
    it 'renders a board' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.render

      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'renders board with ship' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'can fire on board' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.fire("B1")

      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB M . . . \nC . . . . \nD . . . . \n")
    end

    it 'can be sunk' do
      board = Board.new(4)
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.fire("A1")
      board.fire("A2")

      expect(board.render).to eq("  1 2 3 4 \nA H H . . \nB . . . . \nC . . . . \nD . . . . \n")

      board.fire("A3")
      expect(board.render).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end



end
