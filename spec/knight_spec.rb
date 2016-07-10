require 'spec_helper'
require 'knight'

describe 'Knight' do
	before :each do
		@knight = Knight.new("black")
	end

	describe '#initialize' do
		it 'creates an instance of knight when initiated' do
			expect(@knight).to be_an_instance_of(Knight)
		end

		it 'creates a knight for black' do
			expect(@knight.color).to eq("black")
		end	

		it 'outputs black knight for black' do
			expect(@knight.symbol).to eq("\u{265E} ")
		end

		it 'outputs white knight for white' do
			@white_knight = Knight.new("white")
			expect(@white_knight.symbol).to eq("\u{2658} ")
		end				
	end
end