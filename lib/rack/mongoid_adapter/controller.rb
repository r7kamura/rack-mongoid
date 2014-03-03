module Rack
  module MongoidAdapter
    class Controller
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
