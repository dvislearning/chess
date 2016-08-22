class Queen
	attr_reader :color, :symbol, :type
	attr_accessor :captured
	def initialize (color)
		@color = color
		@type = "queen"
		@captured = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2655} " : "\u{265B} "
	end 

def move_up_right(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if (beg[0] > 7) || (beg[1] > 7)
			path << beg
			beg = [(beg[0] + 1), (beg[1] + 1)]
		end
		path << destination
		path.delete(beginning)
		path
	end

	def move_up_left(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if (beg[0] > 7) || (beg[1] < 0)
			path << beg
			beg = [(beg[0] + 1), (beg[1] - 1)]
		end
		path << destination
		path.delete(beginning)
		path
	end	

	def move_down_left(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if (beg[0] < 0) || (beg[1] < 0)
			path << beg
			beg = [(beg[0] - 1), (beg[1] - 1)]
		end
		path << destination
		path.delete(beginning)
		path
	end		

	def move_down_right(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if (beg[0] < 0) || (beg[1] > 7)
			path << beg
			beg = [(beg[0] - 1), (beg[1] + 1)]
		end
		path << destination
		path.delete(beginning)
		path
	end	

		def move_right(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if beg[1] > 7
			path << beg
			beg = [(beg[0]), (beg[1] + 1)]
		end
		path << destination
		path.delete(beginning)
		path
	end

	def move_left(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if beg[1] < 0
			path << beg
			beg = [(beg[0]), (beg[1] - 1)]
		end
		path << destination
		path.delete(beginning)
		path
	end

	def move_up(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if beg[0] > 7
			path << beg
			beg = [(beg[0] + 1), (beg[1])]
		end
		path << destination
		path.delete(beginning)
		path
	end

	def move_down(beginning, destination)
		beg = beginning
		path = []
		while beg != destination
			return false if beg[0] < 0
			path << beg
			beg = [(beg[0] -  1), (beg[1])]
		end
		path << destination
		path.delete(beginning)
		path
	end	

	def move_path(beginning, destination)
		paths = Array.new
		paths << move_up_right(beginning, destination)
		paths << move_down_right(beginning, destination)
		paths << move_up_left(beginning, destination)
		paths << move_down_left(beginning, destination)
		paths << move_up(beginning, destination)
		paths << move_down(beginning, destination)
		paths << move_left(beginning, destination)
		paths << move_right(beginning, destination)		
		result = paths.find { |path| path != false }
		result == nil ? false : result 
	end	
end


