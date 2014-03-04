require "spec_helper"

describe Rack::MongoidAdapter do
  include Rack::Test::Methods

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

  let(:id) do
    "dummy"
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
        response.body.should be_json_as(Array)
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
      it "returns 404" do
        should == 404
        response.body.should be_json
      end
    end

    context "with valid condition" do
      before do
        pending "Not implemented yet"
      end

      it "returns 200 with a resource" do
        should == 200
        response.body.should be_json_as(_id: id)
      end
    end
  end

  describe "POST /:resource_type" do
    before do
      params[:attributes] = { name: "test" }
    end

    let(:method) do
      :post
    end

    let(:path) do
      "/#{resource_type}"
    end

    context "with valid condition" do
      it "returns 201 with a newly-created resource" do
        should == 201
        response.body.should be_json_as(params[:attributes].merge(_id: String))
      end
    end
  end
end
