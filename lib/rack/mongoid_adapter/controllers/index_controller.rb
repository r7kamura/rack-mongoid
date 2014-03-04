module Rack
  module MongoidAdapter
    module Controllers
      class IndexController < Base
        private

        def response_body
          connection.find.to_a.to_json
        end
      end
    end
  end
end
