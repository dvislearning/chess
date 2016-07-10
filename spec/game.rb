	def make_columns
		8.times { @state << [] }
		@state.each { |row| 8.times { row << " R " } }
	end

# def blue_output(string)
# 	puts string.light_blue
# end

# def white_output(string)
# 	puts string.white
# end

# 	def display_board
# 		0.upto(7) do |column|
# 			temp_array = []
# 			0.upto(7) do |row|
# 				print @state[column][row].to_s.gsub('"', '').gsub(',', '') + "\n"
# 			end
# 		end
# 	end

	def display_board
		puts "  "
		8.downto(1) do |row|
			if row%2 == 0
				puts (row.to_s + " " + @state[row-1][0].colorize(:background => :white) + @state[row-1][1].colorize(:background => :light_blue)+ @state[row-1][2].colorize(:background => :white) + @state[row-1][3].colorize(:background => :light_blue) + @state[row-1][4].colorize(:background => :white) + @state[row-1][5].colorize(:background => :light_blue) + @state[row-1][6].colorize(:background => :white) + @state[row-1][7].colorize(:background => :light_blue))
			else
				puts (row.to_s + " " + @state[row-1][0].colorize(:background => :light_blue) + @state[row-1][1].colorize(:background => :white)+ @state[row-1][2].colorize(:background => :light_blue) + @state[row-1][3].colorize(:background => :white) + @state[row-1][4].colorize(:background => :light_blue) + @state[row-1][5].colorize(:background => :white) + @state[row-1][6].colorize(:background => :light_blue) + @state[row-1][7].colorize(:background => :white))
			end
		end
		puts "   A  B  C  D  E  F  G  H"
	end

end

Board.new.display_board