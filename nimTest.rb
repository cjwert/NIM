#Christian Wert & Jacob Adelgren
#Project: NIM
#File: nimTest.rb

require_relative "Nim"
require 'test/unit'

class NimTester < Test::Unit::TestCase

	# test computer player is able to remove stick from any row
	def test_simple_move
		nim = Nim.new
		nim.instance_variable_set(:@computer_choice, "smart_computer_player") # set smart player
		nim.instance_variable_set(:@current_config, [0,0,1] ) # set test case
		nim.send(:smart_computer_player)
		assert_equal( nim.instance_variable_get(:@current_config), [0,0,0] )
		
		nim.instance_variable_set(:@current_config, [0,1,0] ) # set test case
		nim.send(:smart_computer_player)
		assert_equal( nim.instance_variable_get(:@current_config), [0,0,0] )
		
		nim.instance_variable_set(:@current_config, [1,0,0] ) # set test case
		nim.send(:smart_computer_player)
		assert_equal( nim.instance_variable_get(:@current_config), [0,0,0] )
	end

end