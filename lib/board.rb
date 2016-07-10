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
	 	@state[7][2] = Bishop.new("black","white" )
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

#Bishop.new("white", "normal")
Board.new.display_board