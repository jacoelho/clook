module Clook
  class Env
    class << self
      def initialize
      end

      def fetch value
        ENV.fetch value
      end
    end
  end
end
