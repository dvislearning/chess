describe 'Piece' do
	before :each do
		@piece = Piece.new
		@debug_board = DebugBoard.new
	end

	describe '#initialize' do
		it 'creates an instance of piece when initiated', :piece => true do 
			expect(@piece).to be_an_instance_of(Piece)
		end		
	end

	describe '#move_path' do
		it 'returns array with path rook has to take vertically' do
			@debug_board.place_piece("B8", :brook)
			expect(@piece.move_path("B8", "B4")).to eql([[3, 1], [4, 1], [5, 1], [6, 1]])
			expect(@piece.move_path("B4", "B8")).to eql([[4, 1], [5, 1], [6, 1], [7, 1]])
		end

		it 'returns array with path rook has to take horizontally' do
			@debug_board.place_piece("C4", :brook)
			expect(@piece.move_path("C4", "F4")).to eql([[3, 3], [3, 4], [3, 5]])
			expect(@piece.move_path("F4", "C4")).to eql([[3, 2], [3, 3], [3, 4]])
		end
	end		
end