require "spec_helper"

describe Rack::Mongoid::Timestamps::Created do
  let :app do
    Rack::Builder.app do
      use Rack::Mongoid::Timestamps::Created
      run Rack::Mongoid
    end
  end

  describe "POST /:resource_name" do
    it "returns 201 with a newly-created resource including 'created_at'" do
      post "/recipes", { name: "test" }.to_json, {}
      last_response.status.should be 201
      last_response.body.should be_json_as(
        _id: String,
        name: "test",
        created_at: String
      )
    end
  end
end
