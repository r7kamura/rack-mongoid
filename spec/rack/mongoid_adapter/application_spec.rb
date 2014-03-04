require "spec_helper"

describe Rack::MongoidAdapter::Application do
  include Rack::Test::Methods

  before do
    Mongoid.stub(default_session: session_table)
    connection.stub(find: [resource])
  end

  subject do
    send method, path, params, env
    response.status
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

  let(:resource_type) do
    "recipes"
  end

  describe "GET /:resource_type" do
    let(:method) do
      :get
    end

    let(:path) do
      "/#{resource_type}"
    end


    context "with valid condition" do
      it "returns 200 with an array of resources" do
        should == 200
      end
    end
  end

  describe "GET /:resource_type/:id" do
    let(:method) do
      :get
    end

    let(:path) do
      "/#{resource_type}/#{id}"
    end

    context "when resource is not found" do
      let(:resource) do
        nil
      end

      it "returns 404" do
        should == 404
        response.body.should be_json
      end
    end

    context "with valid condition" do
      it "returns 200 with a resource" do
        should == 200
        response.body.should be_json_as(_id: id)
      end
    end
  end
end
