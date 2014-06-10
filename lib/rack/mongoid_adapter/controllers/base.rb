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
          JSON.pretty_generate(message: "Not found", pretty: true) + "\n"
        end

        def request
          @request ||= Rack::Request.new(env)
        end

        def response
          @response ||= Rack::Response.new([response_body], response_status, response_header)
        end

        def resource_name
          request.params["resource_name"]
        end

        def connection
          ::Mongoid.default_session[resource_name]
        end

        def params
          case
          when request.request_method == "GET"
            request.GET
          when !request_body.empty?
            JSON.parse(request_body)
          else
            {}
          end
        end

        def request_body
          @request_body ||= request.body.read.tap { request.body.rewind }
        end
      end
    end
  end
end
