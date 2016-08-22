class Knight
	attr_reader :color, :symbol, :type
	attr_accessor :captured
	def initialize (color)
		@color = color
		@type = "knight"
		@captured = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2658} " : "\u{265E} "
	end 

	def move_path(beginning, destination)
		beg = beginning
		knight_moves = [[2,1], [1,2], [2,-1], [1,-2], [-2,-1], [-1,-2], [-2,1], [-1,2]]
		possible_moves = Array.new
		knight_moves.map { |move| possible_moves << [(beg[0]+move[0]), (beg[1]+move[1])] }
		move = possible_moves.select { |poss| poss == destination}
		move.empty? ? false : move
	end		
end


# a = Knight.new("black")
# puts a.move_path([3,5], [1,4]).inspect