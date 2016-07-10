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

		 # it 'initializes board\'s first row with correct pieces' do
		 # 	expect(@board.state[0][2]).to be_an_instance_of(Bishop)
		 # 	expect(@board.state[0][0]).to be_an_instance_of(Rook)
		 # end			
	end
end