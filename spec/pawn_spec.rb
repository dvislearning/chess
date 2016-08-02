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
	
	describe '#generate_white' do
		it 'returns possible moves for white pawns when called before first move' do
			@white_pawn = Pawn.new("white")
			expect(@white_pawn.generate_white).to eq([[1,0], [1,1], [1,-1], [2, 0]])
		end

		it 'returns possible moves for white pawns when called after first move' do
			@white_pawn = Pawn.new("white")
			@white_pawn.move_white([1, 1], [2, 1])
			expect(@white_pawn.generate_white).to eq([[1,0], [1,1], [1,-1]])
		end		
	end

	describe '#generate_black' do
		it 'returns possible moves for black pawns when called before first move' do
			@black_pawn = Pawn.new("black")
			expect(@black_pawn.generate_black).to eq([[-1,0], [-1,1], [-1,-1], [-2,0]])
		end

		it 'returns possible moves for black pawns when called after first move' do
			@black_pawn = Pawn.new("black")
			@black_pawn.move_black([1, 1], [2, 1])
			expect(@black_pawn.generate_black).to eq([[-1,0], [-1,1], [-1,-1]])
		end	
	end	

	describe '#move_path' do
		context "when pawn is white" do
			it 'returns destination as path if move is possible' do
				@white_pawn = Pawn.new("white")
				expect(@white_pawn.move_path([1, 1], [2, 1])).to eq([[2, 1]])
			end

			it 'returns destination as path if move is possible as first move' do
				@white_pawn = Pawn.new("white")
				expect(@white_pawn.move_path([1, 1], [3, 1])).to eq([[3, 1]])
			end

			it 'returns destination as path if move is possible when capturing' do
				@white_pawn = Pawn.new("white")
				expect(@white_pawn.move_path([1, 1], [2, 0])).to eq([[2, 0]])
				expect(@white_pawn.move_path([1, 1], [2, 2])).to eq([[2, 2]])
			end

			it 'returns false when a move is not allowed' do
				@white_pawn = Pawn.new("white")
				expect(@white_pawn.move_path([1, 1], [0, 1])).to eq(false)
				expect(@white_pawn.move_path([1, 1], [4, 1])).to eq(false)
				expect(@white_pawn.move_path([1, 1], [1, 2])).to eq(false)
			end	

			it 'returns false if trying to move two spaces after pawn has already moved' do
				@white_pawn = Pawn.new("white")
				@white_pawn.move_path([1, 1], [2, 1])
				expect(@white_pawn.move_path([2, 1], [4, 1])).to eq(false)
			end
		end

		context "when pawn is black" do
			it 'returns destination as path if move is possible' do
				@black_pawn = Pawn.new("black")
				expect(@black_pawn.move_path([4, 4], [3, 4])).to eq([[3, 4]])
			end

			it 'returns destination as path if move is possible as first move' do
				@black_pawn = Pawn.new("black")
				expect(@black_pawn.move_path([4, 4], [2, 4])).to eq([[2, 4]])
			end

			it 'returns destination as path if move is possible when capturing' do
				@black_pawn = Pawn.new("black")
				expect(@black_pawn.move_path([4, 4], [3, 3])).to eq([[3, 3]])
				expect(@black_pawn.move_path([4, 4], [3, 5])).to eq([[3, 5]])
			end

			it 'returns false when a move is not allowed' do
				@black_pawn = Pawn.new("black")
				expect(@black_pawn.move_path([4, 4], [5, 4])).to eq(false)
				expect(@black_pawn.move_path([4, 4], [4, 5])).to eq(false)
				expect(@black_pawn.move_path([4, 4], [1, 4])).to eq(false)
			end	

			it 'returns false if trying to move two spaces after pawn has already moved' do
				@black_pawn = Pawn.new("black")
				@black_pawn.move_path([4, 4], [3, 4])
				expect(@black_pawn.move_path([3, 4], [0, 4])).to eq(false)
			end									
		end			
	end					
end