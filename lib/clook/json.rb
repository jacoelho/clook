module Clook
  class Json
    class << self
      def initialize path
        @path = path
      end

      def fetch value
        "#{@path}: #{value}"
      end
    end
  end
end
