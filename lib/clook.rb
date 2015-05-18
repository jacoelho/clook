module Clook
  require "clook/version"
  require "clook/configuration"

  @adapters = Hash.new { |h, k| h[k] = [] }

  class << self
    attr_writer   :configuration
    attr_accessor :adapters

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration) if block_given?
    end

    def load(type, *args, &block)
      require "clook/#{type.to_s}"

      @adapter = const_get("#{type.to_s.capitalize}")
      @adapter.send :initialize, *args, &block
      @adapters[type.to_sym] << @adapter

      unless @configuration.order.include? type.to_sym
        @configuration.order << type.to_sym
      end

    rescue LoadError
      raise "Unknown adapter #{type}"
    end

    def fetch(stuff)
      value = nil
      @configuration.order.each do |prio|
        @adapters[prio].each do |adapter|
          value ||= adapter.fetch(stuff)
        end
      end
      value
    end
  end
end
