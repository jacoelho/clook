require "spec_helper"

describe Clook::Env do

  context "env" do
    before :each do
      allow(ENV).to receive(:[]).with("TEST").and_return("testing")
    end

    it "access variable" do
      value = Clook.fetch("TEST")
      expect(value).to eq("testing")
    end
  end
end
