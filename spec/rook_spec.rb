require 'spec_helper'
require 'rook'
require 'board'

describe 'Rook' do
	before :each do
		@rook = Rook.new("black")
		@debug_board = DebugBoard.new
	end

	describe '#initialize' do
		it 'creates an instance of rook when initiated' do
			expect(@rook).to be_an_instance_of(Rook)
		end

		it 'creates a rook for black' do
			expect(@rook.color).to eq("black")
		end	

		it 'outputs black rook for black' do
			expect(@rook.symbol).to eq("\u{265C} ")
		end

		it 'outputs white rook for white' do
			@white_rook = Rook.new("white")
			expect(@white_rook.symbol).to eq("\u{2656} ")
		end				
	end

	describe '#move_right' do
		it 'returns path when rook makes valid right move' do
			expect(@rook.move_right([6,4], [6,7])).to eq([[6,5], [6,6], [6,7]])
		end

		it 'returns false when rook makes invalid right move' do
			expect(@rook.move_right([6,4], [6,2])).to eq(false)
		end		
	end

	describe '#move_left' do
		it 'returns path when rook makes valid left move' do
			expect(@rook.move_left([2,3], [2,2])).to eq([[2,2]])
		end

		it 'returns false when rook makes invalid left move' do
			expect(@rook.move_left([6,4], [5,2])).to eq(false)
		end		
	end

	describe '#move_up' do
		it 'returns path when rook makes valid up move' do
			expect(@rook.move_up([1,3], [5,3])).to eq([[2,3], [3,3], [4,3], [5,3]])
		end

		it 'returns false when rook makes invalid up move' do
			expect(@rook.move_up([3,5], [9,5])).to eq(false)
		end		
	end

	describe '#move_down' do
		it 'returns path when rook makes valid down move' do
			expect(@rook.move_down([3,2], [0,2])).to eq([[2,2], [1,2], [0,2]])
		end

		it 'returns false when rook makes invalid down move' do
			expect(@rook.move_down([3,2], [-2,2])).to eq(false)
		end		
	end	

	describe '#move_path' do
		it 'returns path when valid rook move is given as argument' do
			expect(@rook.move_path([3,1], [3,6])).to eq([[3,2], [3,3], [3,4], [3,5], [3,6]])
		end

		it 'returns false when rook makes invalid move' do
			expect(@rook.move_path([2,0], [3,5])).to eq(false)
			expect(@rook.move_path([0,0], [6,6])).to eq(false)
			expect(@rook.move_path([7,1], [5,2])).to eq(false)
			expect(@rook.move_path([6,4], [3,7])).to eq(false)
		end
	end		
end