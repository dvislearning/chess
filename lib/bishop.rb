
class Bishop
	attr_reader :color, :symbol, :type
	attr_accessor :captured, :move_history
	def initialize (color)
		@color = color
		@type = "bishop"
		@captured = false
		@move_history = []
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2657} " : "\u{265D} "
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

	def move_path(beginning, destination)
		paths = Array.new
		paths << move_up_right(beginning, destination)
		paths << move_down_right(beginning, destination)
		paths << move_up_left(beginning, destination)
		paths << move_down_left(beginning, destination)
		result = paths.find { |path| path != false }
		result == nil ? false : result 
	end

end

 #  a = Bishop.new("black")
 # # puts a.move_path([7,3], [5,6]).inspect
 # puts a.move_history

