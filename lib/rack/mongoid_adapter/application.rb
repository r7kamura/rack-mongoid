require "rack-multiplexer"

module Rack
  class MongoidAdapter
    class Application
      def call(env)
        router.call(env)
      end

      private

      def router
        @router ||= Rack::Multiplexer.new do
          get "/:resource_type", Controllers::IndexController
          get "/:resource_type/:id", Controllers::ShowController
          post "/:resource_type", Controllers::CreateController
          put "/:resource_type/:id", Controllers::UpdateController
          delete "/:resource_type/:id", Controllers::DestroyController
        end
      end
    end
  end
end
