require 'spec_helper'
require 'board'

describe 'Board' do

	describe '#initialize' do
		before :each do
			@board = Board.new
		end
		
		it 'creates an instance of Board when initiated' do
			expect(@board).to be_an_instance_of(Board)
		end

		it 'creates eight arrays within an array when initialized' do
			expect(@board.state.length).to eq(8)
		end

		it 'creates eight arrays within each of the higher level arrays when initialized' do
			expect(@board.state[0].length).to eq(8)
		end			

		it "correctly initiaizes 1st row pieces for white" do
		 	expect(@board.state[0][0]).to be_an_instance_of(Rook)
		 	expect(@board.state[0][1]).to be_an_instance_of(Knight)
		 	expect(@board.state[0][2]).to be_an_instance_of(Bishop)
		 	expect(@board.state[0][3]).to be_an_instance_of(Queen)
		 	expect(@board.state[0][4]).to be_an_instance_of(King)
		 	expect(@board.state[0][5]).to be_an_instance_of(Bishop)
		 	expect(@board.state[0][6]).to be_an_instance_of(Knight)
		 	expect(@board.state[0][7]).to be_an_instance_of(Rook)
		end
		 
		it "correctly initiaizes with 1st row pieces for black" do
		 	expect(@board.state[7][0]).to be_an_instance_of(Rook)
		 	expect(@board.state[7][1]).to be_an_instance_of(Knight)
		 	expect(@board.state[7][2]).to be_an_instance_of(Bishop)
		 	expect(@board.state[7][3]).to be_an_instance_of(Queen)
		 	expect(@board.state[7][4]).to be_an_instance_of(King)
		 	expect(@board.state[7][5]).to be_an_instance_of(Bishop)
		 	expect(@board.state[7][6]).to be_an_instance_of(Knight)
		 	expect(@board.state[7][7]).to be_an_instance_of(Rook)
		end
		it "correctly initiaizes with row of pawns for black" do
		 	expect(@board.state[6].all?{ |piece| piece.class == Pawn}).to eq(true)
		end
		it "correctly initiaizes with row of pawns for white" do
		 	expect(@board.state[1].all?{ |piece| piece.class == Pawn}).to eq(true)
		end

		it "Initializes each piece with its proper location in move_history array" do
		 	expect(@board.state[7][0].move_history).to eql([[7,0]])
		 	expect(@board.state[7][1].move_history).to eql([[7,1]])
		 	expect(@board.state[7][2].move_history).to eql([[7,2]])
		 	expect(@board.state[7][3].move_history).to eql([[7,3]])
		 	expect(@board.state[7][4].move_history).to eql([[7,4]])
		 	expect(@board.state[7][5].move_history).to eql([[7,5]])
		 	expect(@board.state[7][6].move_history).to eql([[7,6]])
		 	expect(@board.state[7][7].move_history).to eql([[7,7]])
		 	expect(@board.state[0][0].move_history).to eql([[0,0]])
		 	expect(@board.state[0][1].move_history).to eql([[0,1]])
		 	expect(@board.state[0][2].move_history).to eql([[0,2]])
		 	expect(@board.state[0][3].move_history).to eql([[0,3]])
		 	expect(@board.state[0][4].move_history).to eql([[0,4]])
		 	expect(@board.state[0][5].move_history).to eql([[0,5]])
		 	expect(@board.state[0][6].move_history).to eql([[0,6]])
		 	expect(@board.state[0][7].move_history).to eql([[0,7]])
		 	0.upto(7) {|square| expect(@board.state[6][square].move_history).to eql([[6,square]])}
		 	0.upto(7) {|square| expect(@board.state[1][square].move_history).to eql([[1,square]])}
		end			 		 			
	end

	describe '#path_clear?' do
		before :each do
			@debug_board = DebugBoard.new
		end
		
		it 'returns true if given path is unobstructed' do
			expect(@debug_board.path_clear?([[4, 1], [5, 1], [6, 1], [7, 1]])).to eq(true)
		end

		it 'returns false if given path is obstructed' do
			@debug_board.state[6][1] = Rook.new("white")
			expect(@debug_board.path_clear?([[4, 1], [5, 1], [6, 1], [7, 1]])).to eq(false)
		end		
	end

	describe '#move_piece' do
		before :each do
			@debug_board = DebugBoard.new
		end
		
		it 'returns true if given path is unobstructed' do
			expect(@debug_board.path_clear?([[4, 1], [5, 1], [6, 1], [7, 1]])).to eq(true)
		end

		it 'returns false if given path is obstructed' do
			@debug_board.state[3][5] = Rook.new("white")
			@debug_board.move_piece([3,5],[7,5])
			expect(@debug_board.state[7][5]).to be_an_instance_of(Rook)
			expect(@debug_board.state[3][5]).to eq("  ")
		end		
	end

	describe '#find_king' do
		it 'returns position of black king on board' do
			@debug_board = DebugBoard.new
			@debug_board.place_piece("G4", :bking)
			expect(@debug_board.find_king("black")).to eq([3, 6])
		end 
	end

	describe '#square_empty' do
		it 'returns true when given empty square as argument' do
			@debug_board = DebugBoard.new
			expect(@debug_board.square_empty?([2,2])).to be(true)
		end 

		it 'returns false when given occupied square as argument' do
			@debug_board = DebugBoard.new
			@debug_board.place_piece("G4", :bking)
			expect(@debug_board.square_empty?([3,6])).to be(false)
		end 		
	end	

	describe '#check_if_check' do
		before :each do
			@debug_board = DebugBoard.new
			@debug_board.place_piece("C4", :bking)			
		end

		context 'when king is being checked' do
			it 'returns true when being checked by a rook from the right' do
				@debug_board.place_piece("G4", :wrook)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a rook from the left' do
				@debug_board.place_piece("A4", :wrook)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a rook from the top' do
				@debug_board.place_piece("C7", :wrook)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a rook from the bottom' do
				@debug_board.place_piece("C1", :wrook)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the right' do
				@debug_board.place_piece("D4", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the left' do
				@debug_board.place_piece("B4", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the top' do
				@debug_board.place_piece("C5", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the bottom' do
				@debug_board.place_piece("C3", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a bishop from the top-right' do
				@debug_board.place_piece("F7", :wbishop)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a bishop from the top-left' do
				@debug_board.place_piece("A6", :wbishop)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a bishop from the bottom-right' do
				@debug_board.place_piece("E2", :wbishop)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a bishop from the bottom-left' do
				@debug_board.place_piece("A2", :wbishop)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the top-right' do
				@debug_board.place_piece("F7", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the top-left' do
				@debug_board.place_piece("A6", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the bottom-right' do
				@debug_board.place_piece("E2", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a queen from the bottom-left' do
				@debug_board.place_piece("A2", :wqueen)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a white pawn from the left' do
				@debug_board.place_piece("B3", :wpawn)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a white pawn from the right' do
				@debug_board.place_piece("D3", :wpawn)
				expect(@debug_board.check_if_check([3,2],"black")).to be(true)
			end

			it 'returns true when being checked by a black pawn from the left' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("B5", :bpawn)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a black pawn from the right' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("D5", :bpawn)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a king from the right' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("D4", :bking)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end	

			it 'returns true when being checked by a king from the left' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("B4", :bking)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end	

			it 'returns true when being checked by a king from the top' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("C5", :bking)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end	

			it 'returns true when being checked by a king from the bottom' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("C3", :bking)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the top-right-left' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("D6", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the top-right-right' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("E5", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the bottom-right-right' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("E3", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the bottom-right-left' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("D2", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the bottom-left-right' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("B2", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the bottom-left-left' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("A3", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the top-left-left' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("A5", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when being checked by a knight from the top-left-right' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("B6", :bknight)
				expect(@debug_board.check_if_check([3,2],"white")).to be(true)
			end

			it 'returns true when two kings are in same row right with invalid capture path' do
				@debug_board.place_piece("D4", :wking)
				expect(@debug_board.check_if_check([3,3],"white")).to be(true)
			end

			it 'returns true when two kings are in same row left with invalid capture path' do
				@debug_board.place_piece("B4", :wking)
				expect(@debug_board.check_if_check([3,1],"white")).to be(true)
			end

			it 'returns true when two kings are in same comumn up with invalid capture path' do
				@debug_board.place_piece("C5", :wking)
				expect(@debug_board.check_if_check([4,2],"white")).to be(true)
			end	

			it 'returns true when two kings are in same column down with invalid capture path' do
				@debug_board.place_piece("C3", :wking)
				expect(@debug_board.check_if_check([2,2],"white")).to be(true)
			end			

			it 'returns true when two kings are in same diagonal top_right with invalid capture path' do
				@debug_board.place_piece("D5", :wking)
				expect(@debug_board.check_if_check([4,3],"white")).to be(true)
			end


			it 'returns true when two kings are in same diagonal top_left with invalid capture path' do
				@debug_board.place_piece("B5", :wking)
				expect(@debug_board.check_if_check([4,1],"white")).to be(true)				
			end

			it 'returns true when two kings are in same diagonal bottom_right with invalid capture path' do
				@debug_board.place_piece("D3", :wking)
				expect(@debug_board.check_if_check([2,3],"white")).to be(true)				
			end
			
			it 'returns true when two kings are in same diagonal bottom_left with invalid capture path' do
				@debug_board.place_piece("B3", :wking)
				expect(@debug_board.check_if_check([2,1],"white")).to be(true)				
			end	
		end
		
		context 'when king is not being checked' do
			it 'returns false when bishop is in horizontal path' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("F4", :bbishop)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when rook is in diagonal path' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("F1", :brook)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when queen is in knight path' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("B6", :bqueen)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when opposing pawn is in front of king' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("C5", :bpawn)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when own pawn is in capture path' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("B3", :bpawn)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when own piece blocks enemy queen' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("D4", :wqueen)
				@debug_board.place_piece("F4", :bqueen)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when own piece blocks enemy rook' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("C6", :wqueen)
				@debug_board.place_piece("C8", :brook)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when own piece blocks enemy bishop' do
				@debug_board.place_piece("C4", :wking)
				@debug_board.place_piece("B3", :wbishop)
				@debug_board.place_piece("A2", :bbishop)
				expect(@debug_board.check_if_check([3,2],"white")).to be(false)
			end

			it 'returns false when two kings are in same row with invalid capture path' do
				@debug_board.place_piece("A4", :wking)
				expect(@debug_board.check_if_check([3,0],"white")).to be(false)
			end

			it 'returns false when two kings are in same diagonal top_right with invalid capture path' do
				@debug_board.place_piece("F7", :wking)
				expect(@debug_board.check_if_check([6,5],"white")).to be(false)
			end

			it 'returns false when two kings are in same diagonal top_left with invalid capture path' do
				@debug_board.place_piece("A6", :wking)
				expect(@debug_board.check_if_check([5,0],"white")).to be(false)				
			end

			it 'returns false when two kings are in same diagonal bottom_right with invalid capture path' do
				@debug_board.place_piece("F1", :wking)
				expect(@debug_board.check_if_check([0,5],"white")).to be(false)				
			end
			
			it 'returns false when two kings are in same diagonal bottom_left with invalid capture path' do
				@debug_board.place_piece("A2", :wking)
				expect(@debug_board.check_if_check([1,0],"white")).to be(false)				
			end						
		end
	end
end

describe 'DebugBoard' do
	before :each do
		@debug_board = DebugBoard.new
	end

	describe '#place_piece' do
		it 'places pieces in their apporiate squares' do
			@debug_board.place_piece("B6", :bking)
			@debug_board.place_piece("F3", :wqueen)
			@debug_board.place_piece("A8", :bpawn)
			expect(@debug_board.state[5][1]).to be_an_instance_of(King)
			expect(@debug_board.state[2][5]).to be_an_instance_of(Queen)
			expect(@debug_board.state[7][0]).to be_an_instance_of(Pawn)
		end
	end
end

describe 'TemporaryBoard' do		
	it 'creates an instance of TemporaryBoard when initiated' do
		@temp_board = TemporaryBoard.new
		expect(@temp_board).to be_an_instance_of(TemporaryBoard)
	end
end