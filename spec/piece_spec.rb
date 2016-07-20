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
end