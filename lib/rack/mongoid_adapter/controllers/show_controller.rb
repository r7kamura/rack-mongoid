module Rack
  module MongoidAdapter
    module Controllers
      class ShowController < SingleResourceController
        include Mem

        private

        def response_status
          if resource
            200
          else
            404
          end
        end

        def response_body
          if resource
            resource.to_json
          else
            response_body_for_not_found
          end
        end

        def resource
          find_resource
        end
        memoize :resource
      end
    end
  end
end
