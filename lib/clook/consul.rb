require "base64"
require "json"
require "uri"
require "net/http"
require "net/https"

# TODO search services too?
# /v1/catalog/service/<service>
# v1/catalog/nodes

module Clook
  class Consul
    class << self
      DEFAULT_HEADERS = {
        "Content-Type" => "application/json",
        "Accept"       => "application/json",
      }

      def initialize(consul="http://192.168.59.103:8500")
        @consul ||= consul
      end

      def fetch(stuff)
        uri = URI.parse(@consul)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new("/v1/kv/#{stuff}?recurse")

        DEFAULT_HEADERS.each do |key, value|
          request.add_field(key, value)
        end

        response = http.request(request)

        if response.body && (response.content_type || '').include?("json")
          data = JSON.parse(response.body)
        end

        parse(data) unless data.nil?
      end

      def parse(data)
        results = Array.new
        data.map do |item|
          if item["Value"]
            value = Base64.decode64(item["Value"])
            results << (item["Key"].split('/').reverse.reduce(value){ |r, e| {e.to_sym => r} })
          end
        end

        values = squeeze_array(results)
        results.count == 1 ? find_value(values) : values
      end

      def merge(array)
        array.group_by(&:keys).map{ |k, v| { k.first => v.flat_map(&:values).reduce(&:merge) } }.reduce(&:merge)
      end

      def squeeze_array(ary)
        ary
        .group_by(&:keys)
        .map do |k, v|
          flatten_values = v.flat_map(&:values)

          {}.tap do |h|
            h[k.first] = if flatten_values[0].is_a?(Hash)
                           squeze_array(flatten_values)
                         else
                           flatten_values[0]
                         end
          end
        end
        .reduce(&:merge)
      end

      def find_value(hash)
        result = nil
        hash.each do |key, value|
          if hash[key].is_a? Hash
            result = find_value(value)
          else
            result = value
          end
        end
        result
      end

      def flat_hash(input)
        Hash[*input.map { |key, value|
          value.is_a?(Hash) ?
            make_hash_one_dimensional(value).map { |nested_key, nested_value|  ["#{key}/#{nested_key}",nested_value] } :
            [key, value]
        }.flatten]
      end
    end
  end
end
