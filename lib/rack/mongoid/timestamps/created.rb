module Rack
  class Mongoid
    class Timestamps
      class Created < Base
        def appendable?
          request.post?
        end

        def params
          { created_at: timestamp }
        end
      end
    end
  end
end
