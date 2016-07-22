require 'spec_helper'
require 'bishop'

describe 'Bishop' do
	before :each do
		@bishop = Bishop.new("black")
	end

	describe '#initialize' do
		it 'creates an instance of Bishop when initiated' do
			expect(@bishop).to be_an_instance_of(Bishop)
		end

		it 'creates a bishop for black' do
			expect(@bishop.color).to eq("black")
		end	

		it 'outputs black bishop for black' do
			expect(@bishop.symbol).to eq("\u{265D} ")
		end

		it 'outputs white bishop for white' do
			@white_bishop = Bishop.new("white")
			expect(@white_bishop.symbol).to eq("\u{2657} ")
		end				
	end

	describe '#move_up_right' do
		it 'returns path when bishop makes valid up-right move' do
			expect(@bishop.move_up_right([3,2], [6,5])).to eq([[4,3], [5,4], [6,5]])
		end

		it 'returns false when bishop makes invalid up-right move' do
			expect(@bishop.move_up_right([3,2], [6,4])).to eq(false)
		end		
	end

	describe '#move_up_left' do
		it 'returns path when bishop makes valid up-left move' do
			expect(@bishop.move_up_left([1,6], [5,2])).to eq([[2,5], [3,4], [4,3], [5,2]])
		end

		it 'returns false when bishop makes invalid up-left move' do
			expect(@bishop.move_up_left([1,6], [5,7])).to eq(false)
		end		
	end	

	describe '#move_down_left' do
		it 'returns path when bishop makes valid down-left move' do
			expect(@bishop.move_down_left([3,3], [0,0])).to eq([[2,2], [1,1], [0,0]])
		end

		it 'returns false when bishop makes invalid down-left move' do
			expect(@bishop.move_down_left([1,6], [4,2])).to eq(false)
		end		
	end	

	describe '#move_down_right' do
		it 'returns path when bishop makes valid down-right move' do
			expect(@bishop.move_down_right([5,2], [2,5])).to eq([[4,3], [3,4], [2,5]])
		end

		it 'returns false when bishop makes invalid down-right move' do
			expect(@bishop.move_down_right([5,2], [1,2])).to eq(false)
		end		
	end	
end