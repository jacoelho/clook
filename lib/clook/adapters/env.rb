module Clook
  module Adapter
    class Env
      def fetch(value)
        ENV.fetch(value)
      end
    end
  end
end

