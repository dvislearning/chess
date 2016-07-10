require 'spec_helper'
require 'pawn'

describe 'Pawn' do
	before :each do
		@pawn = Pawn.new("black")
	end

	describe '#initialize' do
		it 'creates an instance of pawn when initiated' do
			expect(@pawn).to be_an_instance_of(Pawn)
		end

		it 'creates a pawn for black' do
			expect(@pawn.color).to eq("black")
		end	

		it 'outputs black pawn for black' do
			expect(@pawn.symbol).to eq("\u{265F} ")
		end

		it 'outputs white pawn for white' do
			@white_pawn = Pawn.new("white")
			expect(@white_pawn.symbol).to eq("\u{2659} ")
		end				
	end
end