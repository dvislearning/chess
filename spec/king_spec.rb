require 'spec_helper'
require 'king'

describe 'King' do
	before :each do
		@king = King.new("black")
	end

	describe '#initialize' do
		it 'creates an instance of king when initiated' do
			expect(@king).to be_an_instance_of(King)
		end

		it 'creates a king for black' do
			expect(@king.color).to eq("black")
		end	

		it 'outputs black king for black' do
			expect(@king.symbol).to eq("\u{265A} ")
		end

		it 'outputs white king for white' do
			@white_king = King.new("white")
			expect(@white_king.symbol).to eq("\u{2654} ")
		end				
	end

	describe '#move_path' do
		it 'returns path when valid king move is given as argument' do
			expect(@king.move_path([3,3], [4,2])).to eq([[4,2]])
			expect(@king.move_path([3,3], [4,3])).to eq([[4,3]])
			expect(@king.move_path([3,3], [4,4])).to eq([[4,4]])
			expect(@king.move_path([3,3], [3,2])).to eq([[3,2]])
			expect(@king.move_path([3,3], [3,4])).to eq([[3,4]])
			expect(@king.move_path([3,3], [2,2])).to eq([[2,2]])
			expect(@king.move_path([3,3], [2,3])).to eq([[2,3]])
			expect(@king.move_path([3,3], [2,4])).to eq([[2,4]])
		end

		it 'returns false when king makes invalid move' do
			expect(@king.move_path([3,3], [1,1])).to eq(false)
			expect(@king.move_path([3,3], [5,4])).to eq(false)
			expect(@king.move_path([3,3], [1,3])).to eq(false)
			expect(@king.move_path([3,3], [3,1])).to eq(false)
		end
	end		
end