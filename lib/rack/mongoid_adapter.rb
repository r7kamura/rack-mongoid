require "rack/mongoid_adapter/version"

module Rack
  class MongoidAdapter
    def call(env)
      [200, {}, ["OK"]]
    end
  end
end
