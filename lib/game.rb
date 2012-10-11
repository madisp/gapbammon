require "gapbammon/version"

require 'board'

require 'highline'

module Gapbammon
  class Game
    attr_accessor :players

    def initialize
      @players = []
      @board = Board.new
      @hl = HighLine.new
      @dice = [Die.new, Die.new]
      @player = nil

      colors = ['red', 'black']
      2.times do |i|
        p = hl.ask("Player #{i+1} name? ") { |q| q.default = "Player #{i+1}" }
        players << Player.new(p, colors[i])
      end

      puts "Who starts? Rolling a *FAIR* small throwable object with multiple resting positions..."
      roll = [0,0]
      while roll[0] - roll[1] == 0
        roll = @dice.map {|d| d.roll}
        puts "#{p1} rolls #{roll[0]}"
        puts "#{p2} rolls #{roll[1]}"
        diff = roll[0] - roll[1]
        s = ""
        if diff > 0
          s = "#{p1} starts"
          @player = p1
        elsif diff < 0
          s = "#{p2} starts"
          @player = p2
        else
          s = "Draw! Rolling the object again..."
        end
        puts s
        puts "Press ENTER to continue"
        gets
      end
      turn
    end

    def turn
      b = @board
      print "\e[2J"
      puts b
      roll = @dice.map { |d| d.roll }
      puts "#{@player} rolls #{roll.join(", ")}"
      if roll.uniq.count == 1
        rainbow = %w{red cyan yellow green blue magenta white}
        arr = "DOUBLES".split("")
        doubles = (0...arr.count).collect { |i| arr[i].send(rainbow[i]).bold }.join("")
        puts "ALRIGHT! #{doubles}!"
        roll *= 2
      end

      count = 0
      while not roll.empty?
        if count != 0
          print "\e[2J"
          puts b
          puts "Remaining valid rolls for #{@player}: #{roll.join ", "}"
        end
        count += 1
        valid_moves = b.valid_moves(@player, roll)
        if valid_moves.empty?
          puts "No possible moves :( Skipping #{@player.name}'s turn. Press ENTER to continue.".red
          roll.clear
          gets
        else
          puts "Valid moves:"
          puts (0...valid_moves.count).to_a.map{|i| "#{(i+1).to_s.bold}: #{valid_moves[i]}"}.join("\n")
          index =  hl.ask("Your move? ", Integer) { |q| q.in = (1..valid_moves.count) }
          move = valid_moves[index-1]
          b.make! move
          roll.delete_at(roll.index move.roll)
        end
      end

      if @player == players[0]
        @player = players[1]
      else
        @player = players[0]
      end
      turn
    end

    def over?
       board.out('red') == 15 or board.out('black') == 15
    end

    def p1
      players.first
    end

    def p2
      players.last
    end

    def winner?
      raise "hold yer horses!" unless over?
      if board.out('red') == 15
        "red"
      elsif board.out('black') == 15
        "black"
      end
    end
  end
end
