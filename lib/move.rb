require "gapbammon/version"

module Gapbammon
  class Move
    attr_accessor :player, :position, :steps, :roll

    def initialize(player, position, steps, roll = nil)
      @roll ||= steps
      @roll = @roll.abs
      raise "player not an instance of Player" unless player.is_a? Player
      raise "invalid position" unless (-1..25).include? position
      raise "invalid number of steps" unless (-6..6).include? steps
      @player = player
      @position = position
      @steps = steps
    end

    def new_pos
      position + steps
    end

    def pos_str(pos)
      if pos == 0
        player.color == 'red' ? "out" : "bar"
      elsif pos == 25
        player.color == 'red' ? "bar" : "out"
      else
        pos
      end
    end

    def to_s
      "#{pos_str @position}->#{pos_str new_pos}" 
    end

    def ==(move)
      eql? move
    end

    def eql?(move)
      return false unless move.is_a? Move
      return false unless move.player == player
      return false unless move.position == position
      return false unless move.steps == steps
      return false unless move.roll == roll
      return true
    end

    def hash
      player.hash + position.hash + steps.hash + roll.hash
    end

    def <=>(move)
      ret = position <=> move.position
      ret = new_pos <=> move.new_pos if ret == 0
      ret
    end
  end
end
