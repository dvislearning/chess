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

	def valid_path?(current, destination)
		curr = conv_from_chess(current)
		dest = conv_from_chess(destination)
		(curr[0] == dest[0]) || (curr[1] == dest[1])
	end
end

# a = Rook.new("black")
# puts a.valid_path?("A4", "D4").inspect