require 'spec_helper'
require 'rook'

describe 'Rook' do
	before :each do
		@rook = Rook.new("black")
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
end