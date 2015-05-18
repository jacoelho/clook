module Clook
  require "clook/env"
  require "clook/json"

  @adapters = Hash.new { |h, k| h[k] = [] }
  @order = [:json, :env]

  class << self
    attr_accessor :adapters
    attr_accessor :order

    def load(type, *args, &block)
      @adapter = const_get("#{type.to_s.capitalize}")
      @adapter.send :initialize, *args, &block
      @adapters[type.to_sym] << @adapter

    rescue NameError => e
      raise "Unknown adapter #{e}"
      raise
    end

    def fetch(stuff)
      @order.each do |prio|
        @adapters[prio].each do |adapter|
          puts adapter.fetch(stuff)
        end
      end
    end
  end
end
