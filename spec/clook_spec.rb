require 'spec_helper'
require 'webmock/test_unit'

describe Clook do
  describe "configuration" do
    before(:each) do
      expect(Clook.configuration).to_not be_nil
      expect(Clook.configuration).to be_a Clook::Configuration
      Clook.configuration = Clook::Configuration.new
    end

    it "has configuration block"  do
      expect { |b| Clook.configure(&b) }.to yield_control
    end

    context "Default configuration" do
      let(:config) { Clook.configuration }

      it "Returns a Clook.configuration" do
        expect(config).to be_a Clook::Configuration
      end

      it "Returns a default order" do
        expect(config.order).to be_a(Array)
        expect(config.order).to eq([])
      end
    end

    it "Setup configuration" do
      Clook.configure do |config|
       config.order = [:json, :yaml, :consul]
      end

      expect(Clook.configuration.order).to eq([:json, :yaml, :consul])
    end
  end
end
