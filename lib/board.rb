require "gapbammon/version"

require 'colored'
require_relative 'die'
require_relative 'stone'
require_relative 'player'
require_relative 'move'

module Gapbammon
  class Board
    attr_accessor :stones

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
      barred = bar(player.color)

      rolls.each do |roll|
        roll = -roll if player.color == 'red'
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

      if moves.empty? and barred.empty?
        rolls.each do |roll|
          roll = -roll if player.color == 'red'
          @stones.select{|stone| stone.color == player.color}.each do |stone|
            if player.color == 'red'
              if stone.position + roll <= 0
                moves << Move.new(player, stone.position, -stone.position, roll)
              else
                return []
              end
            else
              if stone.position + roll >= 25
                moves << Move.new(player, stone.position, 25-stone.position, roll)
              else
                return []
              end
            end
          end
        end
      end
      moves.uniq
    end

    def make!(move)
      raise "Invalid move" unless valid_moves(move.player, [move.roll]).include? move
      if (1..24).include? move.new_pos
        stones_on(move.new_pos).select{|s| s.color != move.player.color}.each do |stone|
          stone.position = (stone.color == 'red') ? 25 : 0
        end
      end
      stones_on(move.position).first.position = move.new_pos
    end

    def stones_on(pos)
      @stones.select { |stone| stone.position == pos }
    end

    def bar(color)
      @stones.select { |s| s.color == color and s.position == (color == 'red' ? 25 : 0) }
    end

    def out(color)
      @stones.select { |s| s.color == color and s.position == (color == 'red' ? 0 : 25) }
    end

    def valid?(move)
      winning = true
      stones.select{ |s| move.player.color == s.color }.each do |s|
        if (s.color == 'red' and s.position < 19) or (s.color == 'black' and s.position > 6)
          winning = false
          break
        end
      end
      valid_range = winning ? (0..25) : (1..24)
      stones = stones_on(move.new_pos)
      return false unless valid_range.include? move.new_pos
      return true if stones.empty?
      return true if stones.count == 1
      return true if stones.first.color == move.player.color
      return false
    end

    def to_s
      s = ""
      s << (1..12).to_a.reverse.collect{|i| i.to_s.rjust(2, ' ').bold}.join(" ")
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
      s << "\n"
      %w{bar out}.each do |w|
        s << "#{w}: " + (%w{red black}.collect { |c| self.send(w,c).count.to_s + " " + c }).join(", ") + "\n"
      end
      s
    end
  end
end
