require "spec_helper"

describe Clook do
  context "env" do
    before :each do
      allow(ENV).to receive(:[]).with("TEST").and_return("testing")
    end

    it "fetch a " do
      value = Clook.fetch("TEST")
      expect(value).to eq("testing")
    end
  end
end
