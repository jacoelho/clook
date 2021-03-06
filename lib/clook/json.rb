module Clook
  class Json
    require "json"

    class << self
      def initialize path
        @path = path
      end

      def fetch value
        file = File.read(@path)
        data = JSON.parse(file)
        data[value]
      end
    end
  end
end
