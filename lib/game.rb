require_relative 'board'
require_relative 'pawn'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'player'

# @board = Board.new
@players ||= []


def initialize_player_white
	@players <<  Player.new("white")
end

def initialize_player_black
	@players <<  Player.new("black")
end

def first_move
	puts "White moves first.\n"
end

def prompt_move
	puts "#{@current_player.color.capitalize}, please make a move: "
	gets.chomp.to_s
end

def proper_notation?(entry)
	/[A-Z|a-z][\d] [A-Z|a-z][\d]/ =~ entry ? true : false
end 

def improper_notation
	puts "Improper notation.  Please follow the following format:\n\'e2 e4\' (without quotes)"
end

def within_range?(entry)
	/[A-H|a-h][1-8] [A-H|a-h][1-8]/ =~ entry ? true : false
end 

def not_within_range
	puts "Not Within Range.  Please select squares within the board!"
end

def letter_to_number(letter)
	letter.capitalize.ord-65
end

def conv_from_chess(square)
	column = square[1].to_i - 1
	row = letter_to_number(square[0])
	[column,row]
end

# def convert_square_1(entry)
# 	conv_from_chess(entry[0]+entry[1])
# end

# def convert_square_2(entry)
# 	conv_from_chess(entry[3]+entry[4])
# end

def square_occupied?(square)
	!@board.square_empty?(square)
end

def beg_is_empty(square)
	puts "There is nothin to move in #{square}!"
end

def player_same_color?(entry)
	@board.state[entry[0]][entry[1]].color == @current_player.color
end

def player_cannot_move
	puts "You cannot move a piece that is not yours!"
end

def player_cannot_land
	puts "You cannot move a piece to a square you already occupy!"
end

def get_path(beg, dest)
	@board.state[beg[0]][beg[1]].move_path(beg, dest)
end

def invalid_path(beg)
	puts "You cannot move a #{@board.state[beg[0]][beg[1]].type.capitalize} like that."
end

def invalid_two_move?(beg, path)
 	if @current_player.color == "white"
	 	if ((beg[0]+2 == path.flatten[0]) && (beg[1] == path.flatten[1]))
	 		@board.state[beg[0]][beg[1]].moved == true ? true : false
	 	else
	 		false
	 	end
	 else
	 	if ((beg[0]-2 == path.flatten[0]) && (beg[1] == path.flatten[1]))
	 		@board.state[beg[0]][beg[1]].moved == true ? true : false
	 	else
	 		false
	 	end
 	end	 	
end

def pawn_cant_move_two
	puts "A Pawn may only move two spaces on its first move."
end

def invalid_pawn_capture?(beg, path)
 	if @current_player.color == "white"
	 	if ((beg[0]+1 == path.flatten[0]) && (beg[1]-1 == path.flatten[1])) || ((beg[0]+1 == path.flatten[0]) && (beg[1]+1 == path.flatten[1]))
	 		@board.square_empty?(path.flatten) ? true : false
	 	else
	 		false
	 	end
	 else
	 	if ((beg[0]-1 == path.flatten[0]) && (beg[1]-1 == path.flatten[1])) || ((beg[0]-1 == path.flatten[0]) && (beg[1]+1 == path.flatten[1]))
	 		@board.square_empty?(path.flatten) ? true : false
	 	else
	 		false
	 	end
 	end	 	
end

def pawn_cannot_capture
	puts "You may only move a pawn like this when capturing."
end

def path_clear?(path)
	@board.path_clear?(path)
end

def path_not_clear
	puts "Another piece is blocking you from making that move!"
end  

def pawn_being_moved?(beg)
	@board.state[beg[0]][beg[1]].type == "pawn"
end

def make_pawn_moved(beg)
	@board.state[beg[0]][beg[1]].moved = true
end

def move_piece(beg, dest)
	@board.move_piece(beg, dest)
end

# def make_move
# 	loop do
# 		entry = prompt_move
# 		#improper_notation; redo unless proper_notation?(entry)
# 		a = proper_notation?(entry)
# 		#not_within_range; redo unless within_range?(entry)
# 		return a
# 		break
# 	end
# end


def make_move
	loop do
		entry = prompt_move
		(improper_notation; redo) unless proper_notation?(entry)
		(not_within_range; redo) unless within_range?(entry)
		beg = conv_from_chess(entry[0]+entry[1])
		dest = conv_from_chess(entry[3]+entry[4])
		(beg_is_empty(entry[0]+entry[1]); redo) unless square_occupied?(beg)
		(player_cannot_move; redo) unless player_same_color?(beg)
		path = get_path(beg, dest)
		(invalid_path(beg); redo) if path == false
		# Pawn can move two spaces?
		(pawn_cant_move_two; redo) if invalid_two_move?(beg, path)
		(pawn_cannot_capture; redo) if invalid_pawn_capture?(beg, path)
		(player_cannot_land; redo) if (square_occupied?(dest) && player_same_color?(dest))
		(path_not_clear; redo) unless path_clear?(path[0..-2])
		make_pawn_moved(beg) if pawn_being_moved?(beg)
		move_piece(beg, dest)
		#break
	end
end

 initialize_player_white
 initialize_player_black
 @current_player = @players[1]
# first_move


# loop do
# 	prompt_move
# 	break
# end

@board = DebugBoard.new
 @board.place_piece("c7", :bpawn)
 @board.place_piece("a1", :wrook)
 @board.display_board
# @board.index_board
#puts invalid_pawn_capture?([1,1], [2,0]).inspect
#puts can_pawn_capture?([1,1], [2,0]).inspect
# # puts beg_empty?([0,1]).inspect
# puts @board.state[1][2].moved.inspect
 make_move
# puts @board.state[3][2].moved.inspect
# @board.display_board
# puts proper_notation?("a1 b7").inspect