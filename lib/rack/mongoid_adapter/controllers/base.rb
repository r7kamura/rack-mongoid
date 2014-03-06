module Rack
  class MongoidAdapter
    module Controllers
      class Base
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
          response.to_a
        end

        private

        def response_status
          200
        end

        def response_header
          { "Content-Type" => "application/json" }
        end

        def response_body
          raise NotImplementedError
        end

        def response_body_for_not_found
          { message: "Not found" }.to_json
        end

        def request
          @request ||= Rack::Request.new(env)
        end

        def response
          @response ||= Rack::Response.new([response_body], response_status, response_header)
        end

        def resource_type
          request.params["resource_type"]
        end

        def connection
          ::Mongoid.default_session[resource_type]
        end

        def params
          request.params
        end

        def given_attributes
          params["attributes"]
        end
      end
    end
  end
end
