 require_relative 'board'
 require_relative 'player'


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

def improper_pawn_forward?(beg, dest)
	if @board.state[beg[0]][beg[1]].color == "white"
		if (dest == [beg[0] + 1, beg[1]]) || (dest == [beg[0] + 2, beg[1]])
			return true if (square_occupied?([beg[0] + 1, beg[1]]) || square_occupied?([beg[0] + 2, beg[1]]))
		end
	else
		if (dest == [beg[0] - 1, beg[1]]) || (dest == [beg[0] - 2, beg[1]])
			return true if (square_occupied?([beg[0] - 1, beg[1]]) || square_occupied?([beg[0] - 2, beg[1]]))
		end	
	end
	false
end

def improper_pawn_forward
	puts "Pawns cannot do that"
end

def pawn_cant_move_two
	puts "A Pawn may only move two spaces on its first move."
end

def invalid_pawn_capture?(beg, path)
 	return false if @board.state[beg[0]][beg[1]].type != "pawn"
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

#Checks to see if a move places current_player's King in check

 def moved_into_check?(beg, dest, color)
 	temp_board = TemporaryBoard.new
 	dupe = Marshal.load(Marshal.dump(@board.state))
 	
  	dupe[dest[0]][dest[1]] = dupe[beg[0]][beg[1]]
  	dupe[beg[0]][beg[1]] = "  "

 	temp_board.state = dupe
 	king_location = temp_board.find_king(color)
 	temp_board.check_if_check(king_location, color)
 end

def move_into_check
	puts "This move places your King in check.  Please make a different move."
end

def player_in_check
	puts "Check! - #{@current_player.color.upcase}, you are in check!"
end

def player_checkmate
	puts "Checkmate! #{@current_player.color.upcase} has been checkmated!"
end

def declare_draw
	puts "This contest is a draw!"
end

def make_pawn_moved(beg)
	@board.state[beg[0]][beg[1]].moved = true
end

def move_piece(beg, dest)
	@board.move_piece(beg, dest)
end

# The following methods are used to see if checkmate has occured.

def not_within_hypothetical_range?(dest)
	(dest[0] < 0 || dest[1] < 0) || (dest[0] > 7 || dest[1] > 7)
end


def hypothetical_legal_move?(beg, dest)
	return false if not_within_hypothetical_range?(dest)
	path = get_path(beg, dest)
	return false unless get_path(beg, dest)
	return false if invalid_two_move?(beg, path)
	return false if improper_pawn_forward?(beg, dest)
	return false if invalid_pawn_capture?(beg, path)
	return false unless path_clear?(path[0..-2])
	return false if (square_occupied?(dest) && player_same_color?(dest))
	return false if moved_into_check?(beg, dest, @current_player.color)
	true	
end

def find_player_pieces(color)
	player_pieces = []
	0.upto(7) do |col|
		0.upto(7) do |row| 
			if @board.state[col][row] != "  " &&  @board.state[col][row].color == color
			player_pieces << @board.state[col][row]
			end
		end
	end
	player_pieces
end

def can_king_flee?(color)
	king_loc = @board.find_king(color)
	king = @board.state[king_loc[0]][king_loc[1]]
	possible_moves = king.generate_path(king_loc)
	possible_moves.each { |move| return true if hypothetical_legal_move?(king_loc, move)}
	false
end

def checkmate?
	return false if can_king_flee?(@current_player.color)
 	player_pieces = find_player_pieces(@current_player.color)
 	possible_rescue = Array.new
 	player_pieces.each do |piece|
 	 	piece_location = piece.move_history.pop
		@board.king_checks.check_path.each do |square|
		 	# puts "[#{piece_location}, #{square}] - #{hypothetical_legal_move?(piece_location, square).inspect}"
		 	possible_rescue << hypothetical_legal_move?(piece_location, square)
		end
 	end
 	possible_rescue.all? { |possibilities| possibilities == false }
 end

def play_game
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
		(pawn_cant_move_two; redo) if invalid_two_move?(beg, path)
		(improper_pawn_forward; redo) if improper_pawn_forward?(beg, dest)
		(pawn_cannot_capture; redo) if invalid_pawn_capture?(beg, path)
		(player_cannot_land; redo) if (square_occupied?(dest) && player_same_color?(dest))
		(path_not_clear; redo) unless path_clear?(path[0..-2])
		(move_into_check; redo) if moved_into_check?(beg, dest, @current_player.color)
		make_pawn_moved(beg) if pawn_being_moved?(beg)
		move_piece(beg, dest)
		@board.state[dest[0]][dest[1]].move_history << dest
		@board.display_board
		@current_player = @players.find { |player| player != @current_player }
		if @board.check_if_check(@board.find_king(@current_player.color), @current_player.color)
			if checkmate?
				player_checkmate
				exit
			end
			player_in_check
		end
	end
end

@board = Board.new
@players ||= []
initialize_player_white
initialize_player_black
@current_player = @players[0]
@board.display_board
first_move
play_game

#  @board = DebugBoard.new
#  @board.place_piece("A3", :bking)
#  @board.place_piece("C2", :wking)
#  @board.place_piece("E4", :wpawn)
#  @board.place_piece("E5", :bpawn)
#  @players ||= []
#  initialize_player_white
#  initialize_player_black
#  @current_player = @players[0]
#  @board.display_board
# # first_move
#  play_game

# @board = DebugBoard.new
# @players ||= []
# initialize_player_white
# initialize_player_black
# @current_player = @players[0]
# @board.place_piece("A8", :brook)
# @board.place_piece("B8", :bknight)
# @board.place_piece("C8", :bbishop)
# @board.place_piece("D8", :bqueen)
# @board.place_piece("E8", :bking)
# @board.place_piece("F8", :bbishop)
# @board.place_piece("G8", :bknight)
# @board.place_piece("A7", :bpawn)
# @board.place_piece("B7", :bpawn)
# @board.place_piece("C7", :bpawn)
# @board.place_piece("D7", :bpawn)
# @board.place_piece("E7", :bpawn)
# #@board.place_piece("F6", :bpawn)
# @board.place_piece("G7", :bpawn)
# #@board.place_piece("G6", :wbishop)
# @board.place_piece("H5", :wbishop)

# @board.place_piece("A1", :wrook)
# @board.place_piece("B1", :wknight)
# @board.place_piece("C1", :wbishop)
# @board.place_piece("D1", :wqueen)
# @board.place_piece("E1", :wking)
# @board.place_piece("G1", :wknight)
# @board.place_piece("H1", :wrook)


# @board.place_piece("A2", :wpawn)
# @board.place_piece("B2", :wpawn)
# @board.place_piece("C2", :wpawn)
# @board.place_piece("D2", :wpawn)
# @board.place_piece("E2", :wbishop)
# @board.place_piece("E4", :wpawn)
# @board.place_piece("F2", :wpawn)
# @board.place_piece("G2", :wpawn)
# @board.place_piece("H2", :wpawn)

# @board.check_if_check([0, 0], "white")
# @board.display_board
# # first_move
#  play_game
# #puts @board.check_if_check(@board.find_king(@current_player.color), @current_player.color).inspect
# #puts hypothetical_legal_move?().inspect
# #puts checkmate?.inspect

# # player_pieces = find_player_pieces(@current_player.color)
# # player_pieces.each {|square| puts square.move_history.inspect}