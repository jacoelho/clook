require "spec_helper"

class FakeResponse
  attr :body
  def initialize body
    @body = body
  end
end

describe Clook do
  context "consul" do
    before :each do
      raw_response_file = File.new("./spec/support/files/test1.consul")

      stub_request(:get, %r{\Ahttp://192.168.59.103:8500/.*}).
        with(:headers => {
        'Accept'=>['*/*', 'application/json'],
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/json',
        'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.read(File.join("spec","support","files","test1.consul")), :headers => {})
    end

    it "fetch a value" do
      value = Clook.load_consul().fetch("foo/foo/foo")
      expect(value).to eq("bar")
    end
  end
end
