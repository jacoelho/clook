$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'clook'
require 'webmock/rspec'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
