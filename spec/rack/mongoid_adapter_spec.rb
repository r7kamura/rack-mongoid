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
    resource["_id"]
  end

  let(:resource_name) do
    "recipes"
  end

  let(:resource) do
    post "/#{resource_name}", { attributes: { name: "test" } }, env
    JSON.parse(last_response.body)
  end

  subject do
    send method.downcase, path, params, env
    response.status
  end

  describe "GET /:resource_name" do
    let(:method) do
      "GET"
    end

    let(:path) do
      "/#{resource_name}"
    end

    context "with valid condition" do
      it "returns 200 with an array of resources" do
        should == 200
        response.body.should be_json_as(Array)
      end
    end
  end

  describe "GET /:resource_name/:id" do
    let(:method) do
      "GET"
    end

    let(:path) do
      "/#{resource_name}/#{id}"
    end

    context "when resource is not found" do
      let(:id) do
        BSON::ObjectId.new.to_s
      end

      it "returns 404" do
        should == 404
        response.body.should be_json
      end
    end

    context "with valid condition" do
      it "returns 200 with a resource" do
        should == 200
        response.body.should be_json_as(resource)
      end
    end
  end

  describe "POST /:resource_name" do
    before do
      params[:attributes] = { name: "test" }
    end

    let(:method) do
      "POST"
    end

    let(:path) do
      "/#{resource_name}"
    end

    context "with valid condition" do
      it "returns 201 with a newly-created resource" do
        should == 201
        response.body.should be_json_as(params[:attributes].merge(_id: String))
      end
    end
  end

  describe "PUT /:resource_name/:id" do
    before do
      params[:attributes] = { name: "test" }
    end

    let(:method) do
      "PUT"
    end

    let(:path) do
      "/#{resource_name}/#{id}"
    end

    context "with valid condition" do
      it "returns 204" do
        should == 204
        response.body.should be_empty
      end
    end
  end

  describe "DELETE /:resource_name/:id" do
    let(:method) do
      "DELETE"
    end

    let(:path) do
      "/#{resource_name}/#{id}"
    end

    context "with valid condition" do
      it "returns 204" do
        should == 204
        response.body.should be_empty
      end
    end
  end
end
