require "gapbammon/version"

module Gapbammon
  class Player
    attr_accessor :name, :color

    def initialize(name, color)
      @name = name
      @color = color.downcase
      raise "Invalid color" unless ['red', 'black'].include? @color
    end

    def to_s
      "#{@name} (#{@color})"
    end
  end
end
