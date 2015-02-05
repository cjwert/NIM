#Christian Wert & Jacob Adelgren
#Project: NIM
#File: nim.rb

class Nim 
	# board configurations
	@@config_one = [1,3,5,7]
	@@config_two = [4,3,7]
  @@current_config
	def initialize
		@continue = true
		start_game
	end
	
	# plays the game
	def play
		#while continue
		#send(@computer_choice)		#calls computer method that user chose
    player_move
		#end
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
  
  def player_move
    valid_move = false
    while !valid_move
      display_game
      row_choice = 0
      stick_choice = 0
      puts "Enter the row (1-#{@@current_config.length}): "
      row_choice = gets.chomp.to_i
      puts "Enter the number of sticks (1-#{@@current_config[row_choice]}): "
      stick_choice = gets.chomp.to_i    
      
      if row_choice < @@current_config.length && row_choice > 0
        if stick_choice > 0 && stick_choice <= @@current_config[row_choice]
          @@current_config[row_choice] -= stick_choice
        else
          puts "Invalid number of sticks!"
        end
      else
        puts "Invalid row!"
      end
    end
  end

	def smart_computer_player
		puts "calling smart computer worked"
	end

	def dumb_computer_player
		puts "calling dumb computer worked"
	end
end

game = Nim.new
