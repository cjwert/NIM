#Christian Wert & Jacob Adelgren
#Project: NIM
#File: nim.rb

class Nim 
	# board configurations
	@@config_one = [1,3,5,7]
	@@config_two = [4,3,7]
	def initialize
		@continue = true
		start_game
	end
	
	# plays the game
	def play
		#while continue
		
		#end
	end
	
	def start_game
		# display choices
		puts "1: #{@@config_one}"
		puts "2: #{@@config_two}"
		puts "Select board configuration (1-2):"
		# get user choice
		@choice = gets.chomp.to_i
		play
	end
	
	# get the user's input during each turn
	def display_game
	
	end
end