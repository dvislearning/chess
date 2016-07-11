
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
end		