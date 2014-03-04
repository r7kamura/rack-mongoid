module Rack
  class MongoidAdapter
    module Controllers
      class CreateController < Base
        private

        def response_status
          201
        end

        def response_body
          attributes = given_attributes.merge(_id: Moped::BSON::ObjectId.new)
          connection.insert(attributes)
          attributes.to_json
        end
      end
    end
  end
end
