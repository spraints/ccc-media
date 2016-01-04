require "spec_helper"
require "rack/test"

require_relative "../../app/middlewares/download_directly"

describe DownloadDirectly, :vcr do
  include Rack::Test::Methods

  let(:app) { described_class.new(inner_app) }

  context "no record" do
    let(:inner_app) { ->(env) { [418, {}, ["teatime!"]] } }

    it "does nothing" do
      get "/anything"
      expect(last_response.status).to eq(418)
    end
  end

  context "download record" do
    let(:inner_app) { ->(env) { env[:download_directly] = record; [302, {"Location" => "https://db.tt/v6dsV4YT", "Content-Type" => "text/html"}, ["<html><body>You are being redirected.</body></html>\n"]] } }

    let(:record) { double("downloadable", :public_url => "https://db.tt/v6dsV4YT") }

    it "resolves the URL" do
      get "/anything"
      expect(last_response.status).to eq(200)
      expect(last_response["Location"]).to be_nil
      expect(last_response.body.size).to eq(203975)
    end
  end
end
