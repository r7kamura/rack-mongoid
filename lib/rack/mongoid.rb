require "mem"
require "mongoid"
require "rack"
require "rack-multiplexer"
require "rack/mongoid/controllers/base"
require "rack/mongoid/controllers/single_resource_controller"
require "rack/mongoid/controllers/create_controller"
require "rack/mongoid/controllers/destroy_controller"
require "rack/mongoid/controllers/index_controller"
require "rack/mongoid/controllers/show_controller"
require "rack/mongoid/controllers/update_controller"
require "rack/mongoid/version"

module Rack
  class Mongoid
    DEFAULT_MONGOID_CONFIGURATION_PATH = "config/mongoid.yml"

    class << self
      def call(env)
        configure_mongoid_unless_configured
        instance.call(env)
      end

      private

      def instance
        @instance ||= new
      end

      def configure_mongoid_unless_configured
        ::Mongoid.load!(DEFAULT_MONGOID_CONFIGURATION_PATH) unless ::Mongoid.configured?
      end
    end

    def initialize(app = nil)
      @app = app
    end

    def call(env)
      router.call(env)
    end

    private

    def router
      @router ||= Rack::Multiplexer.new(@app) do
        get "/:resource_name", Controllers::IndexController
        get "/:resource_name/:id", Controllers::ShowController
        post "/:resource_name", Controllers::CreateController
        put "/:resource_name/:id", Controllers::UpdateController
        delete "/:resource_name/:id", Controllers::DestroyController
      end
    end
  end
end
