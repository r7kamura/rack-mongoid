require "mem"
require "mongoid"
require "rack"
require "rack-multiplexer"
require "rack/mongoid_adapter/controllers/base"
require "rack/mongoid_adapter/controllers/single_resource_controller"
require "rack/mongoid_adapter/controllers/create_controller"
require "rack/mongoid_adapter/controllers/destroy_controller"
require "rack/mongoid_adapter/controllers/index_controller"
require "rack/mongoid_adapter/controllers/show_controller"
require "rack/mongoid_adapter/controllers/update_controller"
require "rack/mongoid_adapter/version"

module Rack
  class MongoidAdapter
    def initialize(app = nil)
      @app = app
    end

    def call(env)
      router.call(env)
    end

    private

    def router
      @router ||= Rack::Multiplexer.new(@app) do
        get "/:resource_type", Controllers::IndexController
        get "/:resource_type/:id", Controllers::ShowController
        post "/:resource_type", Controllers::CreateController
        put "/:resource_type/:id", Controllers::UpdateController
        delete "/:resource_type/:id", Controllers::DestroyController
      end
    end
  end
end
