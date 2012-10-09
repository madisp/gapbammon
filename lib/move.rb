require "gapbammon/version"

module Gapbammon
  class Move
    attr_accessor :player, :position, :steps

    def initialize(player, position, steps)
      raise "player not an instance of Player" unless player.is_a? Player
      raise "invalid position" unless (-1..25).include? position
      raise "invalid number of steps" unless (0..6).include? steps
      @player = player
      @position = position
      @steps = steps
    end

    def to_s
      "player: #{@player}, position: #{@position}, steps: #{@steps}" 
    end
  end
end
