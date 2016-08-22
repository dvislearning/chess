require 'colorize'
require_relative 'pawn'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'king_checks'

class Board
	attr_accessor :state, :white_king_pos, :black_king_pos
	def initialize
		@state = []
		@king_checks = KingChecks.new
		make_columns
		initial_positions
		initial_white_king_pos
		initial_black_king_pos
	end


	def make_columns
		8.times { @state << [] }
		@state.each { |row| 8.times { row << "  " } }
	end

	 def initial_positions
	 	@state[7][0] = Rook.new("black")
	 	@state[7][1] = Knight.new("black")
	 	@state[7][2] = Bishop.new("black")
	 	@state[7][3] = Queen.new("black")
	 	@state[7][4] = King.new("black")
	 	@state[7][5] = Bishop.new("black")
	 	@state[7][6] = Knight.new("black")
	 	@state[7][7] = Rook.new("black")
	 	7.downto(0) { |square| @state[6][square] = Pawn.new("black")}
	 	7.downto(0) { |square| @state[1][square] = Pawn.new("white")}
	 	@state[0][0] = Rook.new("white")
	 	@state[0][1] = Knight.new("white")
	 	@state[0][2] = Bishop.new("white")
	 	@state[0][3] = Queen.new("white")
	 	@state[0][4] = King.new("white")
	 	@state[0][5] = Bishop.new("white")
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

	def initial_white_king_pos
		@white_king_pos = [0,4]
	end

	def initial_black_king_pos
		@black_king_pos = [7,4]
	end

	def check_in_path_vert_hori?(path, color)
		path.each do |position| 
			square = @state[position[0]][position[1]]
			next if square != "  " && square.color == color && square.type == "king"
			return true if square != "  " &&
			square.color != color &&
			(square.type == "queen" || square.type == "rook" || square.type == "king")			
			return false if (square != "  " && 
			(square.type != "king" || square.type != "queen" || square.type != "rook"))
		end
		false
	end

	def check_in_path_diag?(path, color)
		path.each do |position| 
			square = @state[position[0]][position[1]]
			next if square != "  " && square.color == color && square.type == "king"
			return true if square != "  " &&
			square.color != color &&
			(square.type == "queen" || square.type == "bishop" || square.type == "king")			
			return false if (square != "  " && 
			(square.type != "king" || square.type != "queen" || square.type != "rook"))
		end
		false
	end	

	def check_in_path_pawns?(path, color)
		path.each do |position| 
			square = @state[position[0]][position[1]]
			next if square != "  " && square.color == color && square.type == "king"
			return true if square != "  " &&
			square.color != color &&
			(square.type == "pawn")
		end
		false
	end

	def check_in_path_knight?(path, color)
		path.each do |position| 
			square = @state[position[0]][position[1]]
			next if square != "  " && square.color == color && square.type == "king"
			return true if square != "  " &&
			square.color != color &&
			(square.type == "knight")
		end
		false
	end	

	def check_right(beg, color)
		path = @king_checks.move_right(beg)
		check_in_path_vert_hori?(path, color)
	end

	def check_left(beg, color)
		path = @king_checks.move_left(beg)
		check_in_path_vert_hori?(path, color)
	end	

	def check_up(beg, color)
		path = @king_checks.move_up(beg)
		check_in_path_vert_hori?(path, color)
	end	

	def check_down(beg, color)
		path = @king_checks.move_down(beg)
		check_in_path_vert_hori?(path, color)
	end	

	def check_up_right(beg, color)
		path = @king_checks.move_up_right(beg)
		check_in_path_diag?(path, color)
	end

	def check_up_left(beg, color)
		path = @king_checks.move_up_left(beg)
		check_in_path_diag?(path, color)
	end	

	def check_down_right(beg, color)
		path = @king_checks.move_down_right(beg)
		check_in_path_diag?(path, color)
	end	

	def check_down_left(beg, color)
		path = @king_checks.move_down_left(beg)
		check_in_path_diag?(path, color)
	end

	def check_down_left(beg, color)
		path = @king_checks.move_down_left(beg)
		check_in_path_diag?(path, color)
	end

	def check_down_left(beg, color)
		path = @king_checks.move_down_left(beg)
		check_in_path_diag?(path, color)
	end

	def check_pawn_down_left(beg, color)
		path = @king_checks.pawn_move_down_left(beg)
		check_in_path_pawns?(path, color)
	end

	def check_pawn_down_right(beg, color)
		path = @king_checks.pawn_move_down_right(beg)
		check_in_path_pawns?(path, color)
	end	

	def check_pawn_up_left(beg, color)
		path = @king_checks.pawn_move_up_left(beg)
		check_in_path_pawns?(path, color)
	end

	def check_pawn_up_right(beg, color)
		path = @king_checks.pawn_move_up_right(beg)
		check_in_path_pawns?(path, color)
	end	

	def check_knight(beg, color)
		path = @king_checks.move_knight(beg)
		check_in_path_knight?(path, color)
	end		

	def check_if_check(beg, color)
		 return true if check_right(beg, color)
		return true if check_left(beg, color)
		return true if check_up(beg, color)
		return true if check_down(beg, color)
		return true if check_up_right(beg, color)
		return true if check_up_left(beg, color)
		return true if check_down_right(beg, color)
		return true if check_down_left(beg, color)
		if @state[beg[0]][beg[1]].color ==  "white"
			return true if check_pawn_up_right(beg, color)
			return true if check_pawn_up_left(beg, color)
		end
		if @state[beg[0]][beg[1]].color ==  "black"
			return true if check_pawn_down_right(beg, color)
			return true if check_pawn_down_left(beg, color)
		end
		return true if check_knight(beg, color)
		false
	end


	def get_king_position(color)
		color == "white" ? white_king_pos : black_king_pos
	end

	def square_empty?(square)
		@state[square[0]][square[1]] == "  "
	end	

	def path_clear?(path)
		path.all? { |square| @state[square[0]][square[1]] == "  "}
	end

	def move_piece(beginning, destination)
		@state[destination[0]][destination[1]] = @state[beginning[0]][beginning[1]]
		@state[beginning[0]][beginning[1]] = "  "
	end		
end


# Used for debugging.  Can be given argument of array with 
# location and pieces you want on the board.

class DebugBoard < Board
	attr_reader :state
	def initialize
		@state = []
		@king_checks = KingChecks.new
		make_columns
	end

	def letter_to_number(letter)
		letter.capitalize.ord-65
	end

	def parse_piece(piece)
		pieces = 
		{:wpawn => Pawn.new("white"),
		:wknight => Knight.new("white"),
		:wbishop => Bishop.new("white"),
		:wrook => Rook.new("white"),
		:wqueen => Queen.new("white"),
		:wking => King.new("white"),
		:bpawn => Pawn.new("black"),
		:bknight => Knight.new("black"),
		:bbishop => Bishop.new("black"),
		:brook => Rook.new("black"),
		:bqueen => Queen.new("black"),
		:bking => King.new("black")}
		pieces[piece]
	end

	def place_piece(position, piece)
		file = position[1].to_i - 1
		rank = letter_to_number(position[0]).to_i
		piece = parse_piece(piece)
		@state[file][rank] = piece
	end

	def conv_from_chess(square)
		column = square[1].to_i - 1
		row = letter_to_number(square[0])
		[column,row]
	end	

	def index_board
		puts "  "
		8.downto(1) do |row|
			if row%2 == 0
				puts ((row-1).to_s + " " + display_square(@state[row-1][0]).colorize(:background => :white) + display_square(@state[row-1][1]).colorize(:background => :light_blue)+ display_square(@state[row-1][2]).colorize(:background => :white) + display_square(@state[row-1][3]).colorize(:background => :light_blue) + display_square(@state[row-1][4]).colorize(:background => :white) + display_square(@state[row-1][5]).colorize(:background => :light_blue) + display_square(@state[row-1][6]).colorize(:background => :white) + display_square(@state[row-1][7]).colorize(:background => :light_blue))
			else
				puts ((row-1).to_s + " " + display_square(@state[row-1][0]).colorize(:background => :light_blue) + display_square(@state[row-1][1]).colorize(:background => :white)+ display_square(@state[row-1][2]).colorize(:background => :light_blue) + display_square(@state[row-1][3]).colorize(:background => :white) + display_square(@state[row-1][4]).colorize(:background => :light_blue) + display_square(@state[row-1][5]).colorize(:background => :white) + display_square(@state[row-1][6]).colorize(:background => :light_blue) + display_square(@state[row-1][7]).colorize(:background => :white))
			end
		end
		puts "  0 1 2 3 4 5 6 7"
	end	
end


 a = DebugBoard.new
 a.place_piece("D3", :wking)
# a.place_piece("C3", :wknight)
# a.place_piece("G6", :bbishop)
a.place_piece("B2", :wknight)
# a.place_piece("C2", :bpawn)
 a.place_piece("C2", :wpawn)
 a.place_piece("C4", :brook)
 #
# a.place_piece("A3", :bking)
 #a.place_piece("D5", :wpawn)
# a.place_piece("G3", :brook)
#  a.place_piece("A3", :bqueen)
 a.index_board
# a.move_piece([3,5],[7,5])
# a.initial_positions
# a.display_board
 puts a.check_if_check([2,3], "white").inspect