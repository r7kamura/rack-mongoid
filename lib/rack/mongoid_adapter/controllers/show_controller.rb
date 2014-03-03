module Rack
  module MongoidAdapter
    module Controllers
      class ShowController < SingleResourceController
        def response_body
          find_resource.to_json
        end
      end
    end
  end
end
