require 'spec_helper'
require 'rook'
require 'board'

describe 'Rook' do
	before :each do
		@rook = Rook.new("black")
		@debug_board = DebugBoard.new
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

	describe '#valid_path?' do
		it 'returns true when moving along a file' do
			@debug_board.place_piece("A2", :brook)
			expect(@rook.valid_path?("A2", "D2")).to eq(true)
		end

		it 'returns true when moving along a rank' do
			@debug_board.place_piece("A2", :brook)
			expect(@rook.valid_path?("A2", "A8")).to eq(true)
		end

		it 'returns false when not moving along rank or file' do
			@debug_board.place_piece("A2", :brook)
			expect(@rook.valid_path?("A2", "B3")).to eq(false)
		end		
	end


	# 	it 'returns false when rook\'s path is obstructed' do
	# 		@debug_board.place_piece("A2", :brook)
	# 		@debug_board.place_piece("B2", :bknight)
	# 		@debug_board.place_piece("C8", :brook)
	# 		@debug_board.place_piece("C4", :wqueen)
	# 		expect(@rook.path_empty?("A2", "D2")).to eq(true)
	# 		expect(@rook.path_empty?("C8", "C1")).to eq(true)
	# 	end	
	# end	
end