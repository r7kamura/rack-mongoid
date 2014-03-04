module Rack
  class MongoidAdapter
    module Controllers
      class SingleResourceController < Base
        include Mem

        private

        def id
          request.params["id"]
        end

        def find_resource
          connection.find(_id: id).first
        end

        def resource
          find_resource
        end
        memoize :resource
      end
    end
  end
end
