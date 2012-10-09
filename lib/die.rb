require "gapbammon/version"

module Gapbammon
  class Die
    def roll
      (1 + (Random.rand * 6).to_i)
    end
  end
end
