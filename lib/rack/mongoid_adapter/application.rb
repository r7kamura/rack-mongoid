require "rack-multiplexer"

module Rack
  module MongoidAdapter
    class Application
      def call(env)
        router.call(env)
      end

      private

      def router
        @router ||= Rack::Multiplexer.new do
          get "/:resource_type/:id", Controllers::ShowController
        end
      end
    end
  end
end
