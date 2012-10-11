require "gapbammon/version"

require_relative 'die'
require_relative 'stone'
require_relative 'player'
require_relative 'move'

module Gapbammon
  class Board
    def initialize(stones=nil)
      @dice = Die.new
      @stones = stones
      if @stones.nil?
        @stones = []
        5.times do
          @stones << Stone.new('black',19)
          @stones << Stone.new('black',12)
          @stones << Stone.new('red',13)
          @stones << Stone.new('red',6)
        end
        3.times do
          @stones << Stone.new('black',17)
          @stones << Stone.new('red',8)
        end
        2.times do
          @stones << Stone.new('black',1)
          @stones << Stone.new('red',24)
        end
      end
    end

    def valid_moves(player, rolls)
      moves = [] # init empty moves
      rolls *= 2 if rolls.first == rolls.last
      rolls.each do |roll|
        roll = -roll if player.color == 'red'
        barred = bar(player.color)
        if barred.empty?
          @stones.select{|stone| stone.color == player.color}.each do |stone|
            move = Move.new(player, stone.position, roll)
            moves << move if valid? move
          end
        else
          move = Move.new(player, barred.first.position, roll)
          moves << move if valid? move
        end
      end
      moves.to_set.to_a
    end

    def make!(move)
      raise "Invalid move" unless valid? move
      stones_on(move.position).first.position = move.new_pos
    end

    def stones_on(pos)
      @stones.select { |stone| stone.position == pos }
    end

    def bar(color)
      @stones.select { |s| s.color == color and s.position == (color == 'red' ? 25 : 0) }
    end

    def valid?(move)
      stones = stones_on(move.new_pos)
      return false unless (1..24).include? move.new_pos
      return true if stones.empty?
      return true if stones.count == 1
      return true if stones.first.color == move.player.color
      return false
    end

    def to_s
      s = ""
      s << (1..12).to_a.reverse.collect{|i| i.to_s.rjust(2, ' ').bold}.join(" ")
#      s << "\n"
#      arr = (1..12).to_a.reverse.collect do |i|
#        stones = stones_on i
#        stones.empty? ? "  " : " " + stones.first.color[0,1].send("white_on_" + stones.first.color)
#      end
#      s << arr.join(" ")
      s << "\n"
      arr = (1..12).to_a.reverse.collect do |i|
        s2 = stones_on(i)
        c = s2.count
        (c == 0) ? ("  ".on_white) : (c.to_s.rjust(2, ' ').bold.send(s2.first.color + "_on_white"))
      end
      s << arr.join(" ".on_white)
      s << "\n"
      4.times do
        s << (("  " * 12) + (" " * 11)).bold.on_white
        s << "\n"
      end
      arr = (13..24).to_a.collect do |i|
        s2 = stones_on(i)
        c = s2.count
        (c == 0) ? ("  ".on_white) : (c.to_s.rjust(2, ' ').bold.send(s2.first.color + "_on_white"))
      end
      s << arr.join(" ".on_white)
      s << "\n"
      s << (13..24).to_a.collect{|i| i.to_s.rjust(2, ' ').bold}.join(" ")
      s
    end
  end
end
