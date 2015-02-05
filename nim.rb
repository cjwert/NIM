#Christian Wert & Jacob Adelgren
#Project: NIM
#File: nim.rb

class Nim 
	# board configurations as class variables

	@@config_one = [1,3,5,7]
	@@config_two = [4,3,7]
	@@current_config
	@winner = 0
	def initialize
		@continue = true
	end
	
	# plays the game
	def play
		while !is_game_over
			player_move
      		send(@computer_choice)		#calls computer method that user chose
  		end
  		display_winner
	end

	def start_game
		# display choices
		puts "1: #{@@config_one}"
		puts "2: #{@@config_two}"
		puts "Select board configuration (1-2):"
		# get user choice
		@board_choice = gets.chomp.to_i
		puts ""
	    # set the selected configuration
	    if( @board_choice == 1) 
	    	@@current_config = @@config_one
	    elsif( @board_choice == 2)
	    	@@current_config = @@config_two
	    end    
		#use introspection to print computer players
		count = 0
		computer_options = Array.new #array to store all computer players found in methods during introspection
		self.methods.each {|method|
			if /computer_player/ =~ method
				count += 1
				computer_options.push(method)
				puts "#{count}: #{method}"
			end
		}
		puts "Select computer player (1-#{count}):"
		computer_number = gets.chomp.to_i
		puts ""
		@computer_choice = computer_options[computer_number - 1]
		play
	end
	

	# get the user's input during each turn
	def display_game
		@@current_config.each.with_index(1) { |row, index|
			print "Row #{index}: "
			row.times{|num| print 'X'}
			puts ""
		}
	end

  # allow the player to make a move
	def player_move
	  	valid_move = false
	  	while !valid_move
	  		display_game
	  		row_choice = 0
	  		stick_choice = 0
		    # get the user selections
		    valid_input = false
		    puts "Enter the row (1-#{@@current_config.length}): "
		    row_choice = gets.chomp.to_i - 1
		    puts "Enter the number of sticks (1-#{@@current_config[row_choice]}): "
		    stick_choice = gets.chomp.to_i    
		    valid_move = validate_move row_choice, stick_choice, true  # validate selections
	  	end
	end

  # determines if a move is valid, if valid, makes move
  # player = true for human, false otherwise
	def validate_move row_choice, stick_choice, player
        if row_choice < @@current_config.length && row_choice >= 0 # ensure row is valid
          	if stick_choice > 0 && stick_choice <= @@current_config[row_choice] # ensure number of sticks is valid
          		# make move if valid
          		@@current_config[row_choice] -= stick_choice
          		valid_move = true
     		elsif player
      			puts "Invalid number of sticks!"
      		end
 		elsif player
  			puts "Invalid row number!"
  		end
  		if valid_move
        	if is_game_over #check if game is over
        		@winner = player #set winner
     		end
      		if !player
        		puts "#{@computer_choice} took #{stick_choice} stick from row #{row_choice + 1}" #display move made by computer
     		end
  		end
  		return valid_move
	end

def smart_computer_player
  	if !is_game_over
	  	row = -1
	  	sticks = -1
	  	test = Array.new(@@current_config)
	  	test.each_with_index {|element, index|
	  		test = Array.new(@@current_config)
	  		result_flag = false
	  		if element > 0
		  		for i in 0..element - 1
		  			test[index] = i
		  			if calc_xor(test) == 0
		  				result_flag = true
		  				break
		  			end
		  		end
		  	end
	  		if result_flag
	  			row = index
	  			sticks = @@current_config[index] - test[index]
	  			break
	  		end
	  	}
	  	# puts "Row:#{row} Sticks:#{sticks}"
	    validate_move row, sticks, false # validate / make move
	end
end

def calc_xor(data)
	result = 0
  	data.each {|element|
  		result = result ^ element
  	}
  	return result
end

def dumb_computer_player
	if !is_game_over
		valid = false
		row = 0
		sticks = 0
		while !valid
	        row = rand(0..@@current_config.length-1) # choose random row
	        sticks = rand(0..@@current_config[row]) # choose random value in that row
	        valid = validate_move row, sticks, false # validate / make move
    	end
	end
end

def is_game_over
	sum = 0
	@@current_config.each{|element|
		sum += element # sum up all of the rows
	}
	if sum > 0
		return false
	else
		return true
	end
end

def auto_play
	@@current_config = @@config_one
	still_playing = true
	while still_playing
	  	# use introspection to call each computer player until game is over
		self.methods.each {|method|
		  	if /computer_player/ =~ method
				if  !is_game_over
					@computer_choice = method # set current player
					send(method) # that player makes a move
				else
					still_playing = false
				end
		  	end
  		}
	end
display_winner
end

def display_winner
    if @winner # winner is true if human player won
    	puts "Congratulations, you win!"
    else
    	puts "#{@computer_choice} wins the game!"
    end
end
end

game = Nim.new
#game.start_game
game.auto_play