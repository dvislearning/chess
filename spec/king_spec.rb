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
end