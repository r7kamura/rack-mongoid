module Rack
  class MongoidAdapter
    module Controllers
      class UpdateController < SingleResourceController
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
            attributes = resource.merge(params)
            connection.find(_id: id).update(attributes)
            attributes.to_json
          else
            response_body_for_not_found
          end
        end
      end
    end
  end
end
