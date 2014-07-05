require "spec_helper"

describe Rack::Mongoid::Timestamps::Updated do
  let :app do
    Rack::Builder.app do
      use Rack::Mongoid::Timestamps::Updated
      run Rack::Mongoid
    end
  end

  let :resource_name do
    "recipes"
  end

  let :request_body do
    { name: "test" }.to_json
  end

  let :resource do
    post "/#{resource_name}", request_body, {}
    JSON.parse(last_response.body)
  end

  let :id do
    resource["_id"]
  end

  describe "PATCH /:resource_name/:id" do
    it "returns 200 with a newly-created resource including 'created_at'" do
      patch "/#{resource_name}/#{id}", request_body, {}
      last_response.status.should be 200
      last_response.body.should be_json_as(
        _id: String,
        name: "test",
        updated_at: String
      )
    end
  end
end
