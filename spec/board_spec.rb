require 'spec_helper'
require 'board'

describe 'Board' do
	before :each do
		@board = Board.new
	end

	describe '#initialize' do
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
	end

	# describe '#square_empty?' do
	# 	it 'returns true when square is empty' do
	# 		@debug_board = DebugBoard.new
	# 		@debug_board.place_piece("A1", :bking)
	# 		expect(@debug_board.square_empty?([7,5])).to eq(true)
	# 		expect(@debug_board.square_empty?([0,0])).to eq(false)
	# 	end		
	# end		
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
			expect(@debug_board.state[1][5]).to be_an_instance_of(King)
			expect(@debug_board.state[5][2]).to be_an_instance_of(Queen)
			expect(@debug_board.state[0][7]).to be_an_instance_of(Pawn)
		end
	end
end