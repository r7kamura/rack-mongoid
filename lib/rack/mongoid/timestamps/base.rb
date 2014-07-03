require "time"

module Rack
  class Mongoid
    class Timestamps
      class Base
        attr_reader :env

        def initialize(app)
          @app = app
        end

        def call(env)
          @env = env
          append_timestamp if appendable?
          @app.call(env)
        end

        private

        def appendable?
          false
        end

        def request
          @request ||= Rack::Request.new(env)
        end

        def append_timestamp
          env["rack.input"] = StringIO.new(input)
        end

        def input
          data = JSON.parse(request_body).merge(params)
          JSON.pretty_generate(data)
        end

        def params
          {}
        end

        def request_body
          @request_body ||= request.body.read.tap { request.body.rewind }
        end

        def timestamp
          Time.now.iso8601
        end
      end
    end
  end
end
