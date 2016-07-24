require_relative 'piece'

class Rook < Piece
	attr_reader :color, :symbol
	attr_accessor :captured
	def initialize (color)
		@color = color
		@captured = false
		@moved = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2656} " : "\u{265C} "
	end 

#Variables curr and dest are temporary.  Combine into the larger function 
#that will contain them later when you write them 

	# def valid_path?(current, destination)
	# 	curr = conv_from_chess(current)
	# 	dest = conv_from_chess(destination)
	# 	(curr[0] == dest[0]) || (curr[1] == dest[1])
	# end

	# def move_path(current, destination)
	# 	curr = conv_from_chess(current)
	# 	dest = conv_from_chess(destination)
	# 	path_container = []
	# 	 if (curr[0] == dest[0]) # Same Row
	# 	 	min_max = [curr[1], dest[1]].minmax
	# 		min_max[0].upto(min_max[1]) { |num|  path_container << [curr[0], num]}
	# 	 else # Same Column
	# 	 	min_max = [curr[0], dest[0]].minmax
	# 	 	min_max[0].upto(min_max[1]) { |num|  path_container << [num, curr[1]]}
	# 	 end
	# 	 path_container.delete(curr)
	# 	 path_container
	# end	

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
		paths << move_up(beginning, destination)
		paths << move_down(beginning, destination)
		paths << move_left(beginning, destination)
		paths << move_right(beginning, destination)
		result = paths.find { |path| path != false }
		result == nil ? false : result 
	end

end

   a = Rook.new("black")
# puts a.move_up([3,5], [9,5]).inspect
# puts a.move_path("E4", "B4").inspect
# puts a.move_path("B6", "B3").inspect
# puts a.move_path("B8", "B4").inspect
# # temp_array[1]..temp_array[-1].all? { |square| square }