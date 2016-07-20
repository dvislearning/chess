require 'colorize'
require_relative 'pawn'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'

class Board
	attr_reader :state
	def initialize
		@state = []
		make_columns
		initial_positions
	end

	def make_columns
		8.times { @state << [] }
		@state.each { |row| 8.times { row << "  " } }
	end

	 def initial_positions
	 	@state[7][0] = Rook.new("black")
	 	@state[7][1] = Knight.new("black")
	 	@state[7][2] = Bishop.new("black","white")
	 	@state[7][3] = Queen.new("black")
	 	@state[7][4] = King.new("black")
	 	@state[7][5] = Bishop.new("black","black")
	 	@state[7][6] = Knight.new("black")
	 	@state[7][7] = Rook.new("black")
	 	7.downto(0) { |square| @state[6][square] = Pawn.new("black")}
	 	7.downto(0) { |square| @state[1][square] = Pawn.new("white")}
	 	@state[0][0] = Rook.new("white")
	 	@state[0][1] = Knight.new("white")
	 	@state[0][2] = Bishop.new("white","black")
	 	@state[0][3] = Queen.new("white")
	 	@state[0][4] = King.new("white")
	 	@state[0][5] = Bishop.new("white","white")
	 	@state[0][6] = Knight.new("white")
	 	@state[0][7] = Rook.new("white")
	 end

	def display_square(content)
		content == "  " ? content : content.symbol
	end

	def display_board
		puts "  "
		8.downto(1) do |row|
			if row%2 == 0
				puts (row.to_s + " " + display_square(@state[row-1][0]).colorize(:background => :white) + display_square(@state[row-1][1]).colorize(:background => :light_blue)+ display_square(@state[row-1][2]).colorize(:background => :white) + display_square(@state[row-1][3]).colorize(:background => :light_blue) + display_square(@state[row-1][4]).colorize(:background => :white) + display_square(@state[row-1][5]).colorize(:background => :light_blue) + display_square(@state[row-1][6]).colorize(:background => :white) + display_square(@state[row-1][7]).colorize(:background => :light_blue))
			else
				puts (row.to_s + " " + display_square(@state[row-1][0]).colorize(:background => :light_blue) + display_square(@state[row-1][1]).colorize(:background => :white)+ display_square(@state[row-1][2]).colorize(:background => :light_blue) + display_square(@state[row-1][3]).colorize(:background => :white) + display_square(@state[row-1][4]).colorize(:background => :light_blue) + display_square(@state[row-1][5]).colorize(:background => :white) + display_square(@state[row-1][6]).colorize(:background => :light_blue) + display_square(@state[row-1][7]).colorize(:background => :white))
			end
		end
		puts "  A B C D E F G H"
	end
end


# Used for debugging.  Can be given argument of array with 
# location and pieces you want on the board.

class DebugBoard < Board
	def initialize
		@state = []
		make_columns
	end

	def letter_to_number(letter)
		letter.capitalize.ord-65
	end

	def parse_piece(piece)
		pieces = 
		{:wpawn => Pawn.new("white"),
		:wknight => Knight.new("white"),
		:wbishop => Bishop.new("white", "normal"),
		:wrook => Rook.new("white"),
		:wqueen => Queen.new("white"),
		:wking => King.new("white"),
		:bpawn => Pawn.new("black"),
		:bknight => Knight.new("black"),
		:bbishop => Bishop.new("black", "normal"),
		:brook => Rook.new("black"),
		:bqueen => Queen.new("black"),
		:bking => King.new("black")}
		pieces[piece]
	end

	def place_piece(position, piece)
		file = position[1].to_i - 1
		rank = letter_to_number(position[0]).to_i
		piece = parse_piece(piece)
		@state[rank][file] = piece
	end

	def conv_from_chess(square)
		column = square[1].to_i - 1
		row = letter_to_number(square[0])
		[column,row]
	end	

end


 a = DebugBoard.new
 a.display_board
 puts a.conv_from_chess("B8").inspect
 puts a.conv_from_chess("B4").inspect