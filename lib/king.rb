class King
	attr_reader :color, :symbol, :type
	attr_accessor :captured, :move_history
	def initialize (color)
		@color = color
		@type = "king"
		@captured = false
		@moved = false
		@move_history = []
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2654} " : "\u{265A} "
	end 

	def generate_path(beg)
		king_moves = [[1,-1], [1,0], [1,1], [0,-1], [0,1], [-1,-1], [-1,0], [-1,1]]
		possible_moves = Array.new
		king_moves.map { |move| possible_moves << [(beg[0]+move[0]), (beg[1]+move[1])] }
		possible_moves
	end		

	def move_path(beginning, destination)
		piece_path = generate_path(beginning)
		move = piece_path.select { |poss| poss == destination}
		move.empty? ? false : move
	end		
end