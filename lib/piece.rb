
#Piece class is the superclass for all the various chess pieces
class Piece
	def conv_from_chess(square)
		column = square[1].to_i - 1
		row = letter_to_number(square[0])
		[column,row]
	end

	def letter_to_number(letter)
		letter.capitalize.ord-65
	end

	def square_empty?(square)
		@state[square[0]][square[1]] == "  "
	end	


	def move_path(current, destination)
		curr = conv_from_chess(current)
		dest = conv_from_chess(destination)
		path_container = []
		 if (curr[0] == dest[0]) # Same Row
		 	min_max = [curr[1], dest[1]].minmax
			min_max[0].upto(min_max[1]) { |num|  path_container << [curr[0], num]}
		 else # Same Column
		 	min_max = [curr[0], dest[0]].minmax
		 	min_max[0].upto(min_max[1]) { |num|  path_container << [num, curr[1]]}
		 end
		 path_container.delete(curr)
		 path_container
	end		
end		