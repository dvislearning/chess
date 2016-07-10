class Rook
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
end


