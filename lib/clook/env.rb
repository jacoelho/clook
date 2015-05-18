module Clook
  class Env
    class << self
      def initialize
      end

      def fetch value
        ENV[value.upcase]
      end
    end
  end
end
