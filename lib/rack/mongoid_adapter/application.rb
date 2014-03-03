module Rack
  module MongoidAdapter
    class Application
      def call(env)
        [200, {}, ["OK"]]
      end
    end
  end
end
