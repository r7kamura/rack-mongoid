module Rack
  module MongoidAdapter
    module Controllers
      class SingleResourceController < Base
        private

        def id
          request.params["id"]
        end

        def find_resource
          connection.find(id).first
        end
      end
    end
  end
end
