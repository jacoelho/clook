module Clook
  class Yaml
    require "yaml"

    class << self
      def initialize path
        @path = path
      end

      def fetch value
        file = File.read(@path)
        data = YAML::load(file)
        data[value]
      end
    end
  end
end
