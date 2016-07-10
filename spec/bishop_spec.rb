require 'spec_helper'
require 'bishop'

describe 'Bishop' do
	before :each do
		@bishop = Bishop.new("black", "black")
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
			@white_bishop = Bishop.new("white", "black")
			expect(@white_bishop.symbol).to eq("\u{2657} ")
		end				
	end
end