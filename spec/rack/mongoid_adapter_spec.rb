require "spec_helper"

describe Rack::Mongoid do
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
    post "/#{resource_name}", { name: "test" }.to_json, env
    JSON.parse(last_response.body)
  end

  let(:request_body) do
    case method
    when "POST", "PUT"
      params.to_json
    else
      params
    end
  end

  subject do
    send method.downcase, path, request_body, env
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
      params[:name] = "test"
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
        response.body.should be_json_as(
          _id: String,
          name: "test"
        )
      end
    end
  end

  describe "PUT /:resource_name/:id" do
    before do
      params[:name] = "test"
    end

    let(:method) do
      "PUT"
    end

    let(:path) do
      "/#{resource_name}/#{id}"
    end

    context "with valid condition" do
      it "returns 200" do
        should == 200
        response.body.should be_json_as(
          _id: String,
          name: "test",
        )
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
      it "returns 200" do
        should == 200
        response.body.should be_json_as(
          _id: String,
          name: "test",
        )
      end
    end
  end
end
