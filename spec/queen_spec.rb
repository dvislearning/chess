require 'spec_helper'
require 'queen'

describe 'Queen' do
	before :each do
		@queen = Queen.new("black")
	end

	describe '#initialize' do
		it 'creates an instance of queen when initiated' do
			expect(@queen).to be_an_instance_of(Queen)
		end

		it 'creates a queen for black' do
			expect(@queen.color).to eq("black")
		end	

		it 'outputs black queen for black' do
			expect(@queen.symbol).to eq("\u{265B} ")
		end

		it 'outputs white queen for white' do
			@white_queen = Queen.new("white")
			expect(@white_queen.symbol).to eq("\u{2655} ")
		end				
	end

	describe '#move_path' do
		it 'returns path when valid queen move is given as argument' do
			expect(@queen.move_path([5,2], [2,5])).to eq([[4,3], [3,4], [2,5]])
			expect(@queen.move_path([2,3], [2,7])).to eq([[2,4], [2,5], [2,6], [2,7]])
		end

		it 'returns false when queen makes invalid move' do
			expect(@queen.move_path([7,0], [5,1])).to eq(false)
			expect(@queen.move_path([6,2], [1,1])).to eq(false)
			expect(@queen.move_path([7,1], [0,7])).to eq(false)
		end	
	end	
end