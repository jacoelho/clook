require "base64"
require "json"
require "uri"
require "net/http"
require "net/https"

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
        request = Net::HTTP::Get.new("/v1/kv/#{stuff}")

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
        if data.count == 1
          item = data.first["Value"]
          value = Base64.decode64(item) unless item.nil?
        else
          value = data.map do |item|
            { :name  => item["Name"],
              :value => (Base64.decode64(item["Payload"]) unless item["Payload"].nil?)}
            end
         end
      end
    end
  end
end
