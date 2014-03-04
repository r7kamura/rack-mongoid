module Rack
  class MongoidAdapter
    module Controllers
      class SingleResourceController < Base
        private

        def id
          Moped::BSON::ObjectId.from_string(request.params["id"])
        end

        def find_resource
          connection.find(_id: id).first
        end
      end
    end
  end
end
