class Knight
	attr_reader :color, :symbol
	attr_accessor :captured
	def initialize (color)
		@color = color
		@captured = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2658} " : "\u{265E} "
	end 
end


