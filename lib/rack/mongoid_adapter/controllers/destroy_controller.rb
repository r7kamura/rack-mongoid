module Rack
  class MongoidAdapter
    module Controllers
      class DestroyController < SingleResourceController
        def response_status
          if resource
            200
          else
            404
          end
        end

        def response_body
          if resource
            connection.find(_id: id).remove
            resource.to_json
          else
            response_body_for_not_found
          end
        end
      end
    end
  end
end
