require "gapbammon/version"

module Gapbammon
	class Game
		attr_accessor :players
		def initialize
			@players = []
		end
			
		def over?
			#TODO
		end

		def winner?
			#TODO
		end

		def add_player(player)
			raise "player not an instance of Player" unless player.is_a? Player	
		end
	end
end
