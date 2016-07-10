class Bishop
	attr_reader :color, :type, :symbol
	attr_accessor :captured
	def initialize (color, type)
		@color = color
		@type = type
		@captured = false
		assign_symbol 
	end

	def assign_symbol
		@symbol = @color == "white" ? "\u{2657} " : "\u{265D} "
	end 
end


