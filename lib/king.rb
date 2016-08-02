class King
	attr_reader :color, :symbol
	attr_accessor :captured
	def initialize (color)
		@color = color
		@captured = false
		@moved = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2654} " : "\u{265A} "
	end 

	def move_path(beginning, destination)
		beg = beginning
		king_moves = [[1,-1], [1,0], [1,1], [0,-1], [0,1], [-1,-1], [-1,0], [-1,1]]
		possible_moves = Array.new
		king_moves.map { |move| possible_moves << [(beg[0]+move[0]), (beg[1]+move[1])] }
		move = possible_moves.select { |poss| poss == destination}
		move.empty? ? false : move
	end		
end

#How do I check if the king is being checked?  
#Have him do the lehal move of every piece.
#If he encounters a piece of the opposite color, heis in check.

a = King.new("black")
puts a.move_path([3,5], [5,5]).inspect
