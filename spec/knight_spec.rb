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

	describe '#move_path' do
		it 'returns path when valid knight move is given as argument' do
			expect(@knight.move_path([3,3], [1,2])).to eq([[1,2]])
			expect(@knight.move_path([3,3], [2,1])).to eq([[2,1]])
			expect(@knight.move_path([3,3], [1,4])).to eq([[1,4]])
			expect(@knight.move_path([3,3], [2,5])).to eq([[2,5]])
			expect(@knight.move_path([3,3], [4,1])).to eq([[4,1]])
			expect(@knight.move_path([3,3], [5,2])).to eq([[5,2]])
			expect(@knight.move_path([3,3], [5,4])).to eq([[5,4]])
			expect(@knight.move_path([3,3], [4,5])).to eq([[4,5]])
		end

		it 'returns false when knight makes invalid move' do
			expect(@knight.move_path([2,0], [0,0])).to eq(false)
			expect(@knight.move_path([0,0], [0,1])).to eq(false)
			expect(@knight.move_path([7,1], [4,2])).to eq(false)
			expect(@knight.move_path([6,4], [2,3])).to eq(false)
		end
	end		
end