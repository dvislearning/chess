class Queen
	attr_reader :color, :symbol
	attr_accessor :captured
	def initialize (color)
		@color = color
		@captured = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2655} " : "\u{265B} "
	end 
end


