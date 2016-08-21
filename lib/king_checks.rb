class KingChecks
# Vertical and Horizontal moves

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
# Diagonal Moves
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
end

 a = KingChecks.new
 puts a.move_down_right([5,0]).inspect
