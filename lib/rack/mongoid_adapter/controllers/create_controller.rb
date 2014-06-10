module Rack
  class MongoidAdapter
    module Controllers
      class CreateController < Base
        private

        def response_status
          201
        end

        def response_body
          attributes = params.merge(_id: BSON::ObjectId.new.to_s)
          connection.insert(attributes)
          JSON.pretty_generate(attributes, pretty: true) + "\n"
        end
      end
    end
  end
end
