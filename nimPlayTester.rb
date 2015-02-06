#Christian Wert & Jacob Adelgren
#Project: @nim
#File: @nimPlayTester.rb

require_relative "Nim"

class NimTester
	def initialize
		@nim = Nim.new
		@nim.set_for_autoplay
	end

	def auto_play
		i = 0
		while i < 20
			play_round
			i+=1
		end
	end
	
	def play_round
		still_playing = true
		while still_playing
			# use introspection to call each computer player until game is over
			Nim.instance_methods.each {|method|
				if /computer_player/ =~ method
					if  !@nim.is_game_over
						@nim.instance_variable_set(:@computer_choice, method) # set current player
						@nim.send(method) # that player makes a move
					else
						still_playing = false # the game ends
					end
				end
			}
		end
	@nim.display_winner
	end
end

demo = NimTester.new
demo.auto_play