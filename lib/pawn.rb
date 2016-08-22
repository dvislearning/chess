class Pawn
	attr_reader :color, :symbol, :type
	attr_accessor :captured, :moved
	def initialize (color)
		@color = color
		@type = "pawn"
		@captured = false
		@moved = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2659} " : "\u{265F} "
	end 


	# def generate_white
	# 	pawn_moves = [[1,0], [1,1], [1,-1]]
	# 	pawn_moves << [2,0] if @moved == false
	# 	pawn_moves
	# end

	# def generate_black
	# 	pawn_moves = [[-1,0], [-1,1], [-1,-1]]
	# 	pawn_moves << [-2,0] if @moved == false
	# 	pawn_moves
	# end

	# def move_white (beginning, destination)
	# 	beg = beginning
	# 	pawn_moves = generate_white
	# 	@moved = true
	# 	possible_moves = Array.new
	# 	pawn_moves.map { |move| possible_moves << [(beg[0]+move[0]), (beg[1]+move[1])] }
	# 	move = possible_moves.select { |poss| poss == destination}
	# 	move.empty? ? false : move
	# end

	# def move_black (beginning, destination)
	# 	beg = beginning
	# 	pawn_moves = generate_black
	# 	@moved = true
	# 	possible_moves = Array.new
	# 	pawn_moves.map { |move| possible_moves << [(beg[0]+move[0]), (beg[1]+move[1])] }
	# 	move = possible_moves.select { |poss| poss == destination}
	# 	move.empty? ? false : move
	# end

	def generate_white
		pawn_moves = [[1,0], [1,1], [1,-1], [2,0]]
	end

	def generate_black
		pawn_moves = [[-1,0], [-1,1], [-1,-1], [-2,0]]
	end

	def move_white (beginning, destination)
		beg = beginning
		pawn_moves = generate_white
		possible_moves = Array.new
		pawn_moves.map { |move| possible_moves << [(beg[0]+move[0]), (beg[1]+move[1])] }
		move = possible_moves.select { |poss| poss == destination}
		move.empty? ? false : move
	end

	def move_black (beginning, destination)
		beg = beginning
		pawn_moves = generate_black
		possible_moves = Array.new
		pawn_moves.map { |move| possible_moves << [(beg[0]+move[0]), (beg[1]+move[1])] }
		move = possible_moves.select { |poss| poss == destination}
		move.empty? ? false : move
	end

	def move_path(beginning, destination)
		if self.color == "white"
			move_white(beginning, destination)
		else
			move_black(beginning, destination)
		end
	end

end

 # a = Pawn.new("black")
 # puts a.move_path([1,0],[0,0]).inspect


