class KingChecks
# Vertical and Horizontal checks

	def move_right(beginning)
		beg = beginning
		path = []	
		beg[1].upto(7) do |x|
			path << beg
			beg = [(beg[0]), (beg[1] + 1)]
		end
		path
	end

	def move_left(beginning)
		beg = beginning
		path = []	
		beg[1].downto(0) do |x|
			path << beg
			beg = [(beg[0]), (beg[1] - 1)]
		end
		path
	end


	def move_up(beginning)
		beg = beginning
		path = []	
		beg[0].upto(7) do |x|
			path << beg
			beg = [(beg[0] + 1), (beg[1])]
		end
		path
	end

	def move_down(beginning)
		beg = beginning
		path = []	
		beg[0].downto(0) do |x|
			path << beg
			beg = [(beg[0] - 1), (beg[1])]
		end
		path		
	end	

# Diagonal checks

	def move_up_right(beginning)
		beg = beginning
		path = []
		while (beg[0] <= 7) && (beg[1] <= 7)
			path << beg
			beg = [(beg[0] + 1), (beg[1] + 1)]
		end			
		path
	end

	def move_up_left(beginning)
		beg = beginning
		path = []
		while (beg[0] <= 7) && (beg[1] >= 0)
			path << beg
			beg = [(beg[0] + 1), (beg[1] - 1)]
		end			
		path
	end

	def move_down_left(beginning)
		beg = beginning
		path = []
		while (beg[0] >= 0) && (beg[1] >= 0)
			path << beg
			beg = [(beg[0] - 1), (beg[1] - 1)]
		end			
		path
	end

	def move_down_right(beginning)
		beg = beginning
		path = []
		while (beg[0] >= 0) && (beg[1] <= 7)
			path << beg
			beg = [(beg[0] - 1), (beg[1] + 1)]
		end			
		path
	end

# Pawn checks

	def pawn_move_up_right(beginning)
		beg = beginning
		return [beg] if beg[0] >= 7 || beg[1] >= 7
		[beg, [beg[0]+1, beg[1]+1]]
	end

	def pawn_move_up_left(beginning)
		beg = beginning
		return [beg] if beg[0] >= 7 || beg[1] <= 0
		[beg, [beg[0]+1, beg[1]-1]]
	end

	def pawn_move_down_left(beginning)
		beg = beginning
		return [beg] if beg[0] <= 0 || beg[1] <= 0
		[beg, [beg[0]-1, beg[1]-1]]
	end	

	def pawn_move_down_right(beginning)
		beg = beginning
		return [beg] if beg[0] <= 0 || beg[1] >= 7
		[beg, [beg[0]-1, beg[1]+1]]
	end

# Knight checks
	def move_knight(beginning)
		beg = beginning
		knight_moves = [[2,1], [1,2], [2,-1], [1,-2], [-2,-1], [-1,-2], [-2,1], [-1,2]]
		possible_moves = Array.new
		knight_moves.map do |move| 
			square = [(beg[0]+move[0]), (beg[1]+move[1])]
			possible_moves << square if (square[0] >= 0 && square[0] <= 7) && (square[1] >= 0 && square[1] <= 7)
		end
		possible_moves
	end
end

 #  a = KingChecks.new
 # puts a.move_knight([6,0]).inspect
