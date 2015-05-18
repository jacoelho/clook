module Clook
  class Adapter
    def initialize
      @adapters = {}
    end

    def setup
      @adapters[:env] = "cenas"
    end
  end
end
