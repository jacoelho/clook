require "spec_helper"

describe Clook::Env do

  context "env" do
    it "env adapter" do
      hostname = Clook.fetch("hostname")

      expect(hostname).to be(nil)
    end
  end
end
