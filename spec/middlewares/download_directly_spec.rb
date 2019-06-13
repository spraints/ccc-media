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

    context "resolves the URL" do
      before { get "/anything" }
      it { expect(last_response.status).to eq(200) }
      it { expect(last_response["Location"]).to be_nil }
      # These don't work, the URL on the :record has expired
      #it { expect(last_response["Content-Disposition"]).to eq("inline; filename=\"bulletin 010316 pdf.pdf\"; filename*=UTF-8''bulletin%20010316%20pdf.pdf") }
      #it { expect(last_response["Content-Type"]).to eq("application/pdf") }
      #it { expect(last_response.body.size).to eq(88184) }
    end
  end
end
