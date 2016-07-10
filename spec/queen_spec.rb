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
end