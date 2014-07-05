module Rack
  class Mongoid
    class Timestamps
      class Updated < Base
        def appendable?
          request.post? || request.put? || request.patch?
        end

        def params
          { updated_at: timestamp }
        end
      end
    end
  end
end
