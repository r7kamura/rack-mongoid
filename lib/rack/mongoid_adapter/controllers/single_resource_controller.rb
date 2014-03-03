module Rack
  module MongoidAdapter
    module Controllers
      class SingleResourceController < Base
        private

        def id
          request.params["id"]
        end

        def find_resource
          ::Mongoid.default_session[resource_type].find(id)
        end
      end
    end
  end
end
