module Rack
  module MongoidAdapter
    module Controllers
      class ShowController < Base
        def response_body
          find_resource.to_json
        end

        private

        def find_resource
          ::Mongoid.default_session[resource_type].find(id)
        end
      end
    end
  end
end
