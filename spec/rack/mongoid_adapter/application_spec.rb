require "spec_helper"

describe Rack::MongoidAdapter::Application do
  include Rack::Test::Methods

  before do
    Mongoid.stub(default_session: session_table)
  end

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

  let(:connection) do
    double
  end

  let(:session_table) do
    Hash.new(connection)
  end

  let(:id) do
    "dummy"
  end

  let(:resource) do
    { _id: id }
  end

  describe "GET /:resource_type/:id" do
    before do
      connection.stub(:find) do |id|
        [resource]
      end
    end

    it "behaves like a rack application" do
      get "/recipes/#{id}", params, env
      response.status.should == 200
      response.body.should be_json_as(_id: id)
    end
  end
end
