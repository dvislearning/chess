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