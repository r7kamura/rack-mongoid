module Rack
  module MongoidAdapter
    class Controller
      class << self
        def call(env)
          new(env).call
        end
      end

      attr_reader :env

      def initialize(env)
        @env = env
      end

      def call
        [200, {}, ["OK"]]
      end

      private

      def request
        @request ||= Rack::Request.new(env)
      end
    end
  end
end
