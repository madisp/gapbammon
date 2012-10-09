require "gapbammon/version"
 
module Gapbammon
  class Stone
    attr_accessor :color, :position

    def initialize(color, position)
      @color = color.downcase
      raise "Invalid color" unless ['red', 'black'].include? @color
      @position = position
      raise "Invalid position" unless (-1..25).include? position
    end
    
    def to_s
      "#{@color} (#{@position})"
    end
  end
end
