require "spec_helper"

describe Rack::MongoidAdapter do
  include Rack::Test::Methods

  let(:app) do
    described_class.new
  end

  let(:params) do
    {}
  end

  let(:env) do
    {}
  end

  let(:response) do
    last_response
  end

  describe "#call" do
    it "behaves like a rack application" do
      get "/recipes", params, env
      response.status.should == 200
    end
  end
end
