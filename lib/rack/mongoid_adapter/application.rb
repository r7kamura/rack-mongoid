module Rack
  module MongoidAdapter
    class Application
      def call(env)
        Controller.new(env).call
      end
    end
  end
end
