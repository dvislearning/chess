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
end