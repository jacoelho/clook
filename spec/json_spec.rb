require "spec_helper"

describe Clook do
  context "json" do
    let(:value)  { Clook.load_json("spec/support/files/test.json").fetch("firstName") }

    it 'fetch a value' do
      expect(value).to eq "John"
    end
  end
end

