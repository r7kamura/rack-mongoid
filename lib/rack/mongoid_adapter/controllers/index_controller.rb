module Rack
  class MongoidAdapter
    module Controllers
      class IndexController < Base
        private

        def response_body
          JSON.pretty_generate(connection.find.to_a) + "\n"
        end
      end
    end
  end
end
