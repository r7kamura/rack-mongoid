$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rack/mongoid_adapter"
require "rack/test"
require "rspec/json_matcher"

ENV["RACK_ENV"] ||= "test"
Mongoid.load!(File.expand_path("../config/mongoid.yml", __FILE__))

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include RSpec::JsonMatcher
end
