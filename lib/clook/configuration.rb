module Clook
  class Configuration
    attr_accessor :order

    def initialize(options = {})
      @order = options[order] || [:env]
    end
  end
end
