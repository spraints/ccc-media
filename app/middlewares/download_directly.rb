# Peel off the redirects
class DownloadDirectly
  def initialize(app)
    @app = app
  end

  def call(env)
    result = @app.call(env)
    if env[:download_directly] && location = result[1]["Location"]
      seen = {}
      until location.nil? || seen[location]
        seen[location] = true
        uri = URI(location)
        response = get_response(uri)
        if response.is_a?(Net::HTTPRedirection)
          location = response["Location"]
        else
          return [200, {"Content-Type" => response["Content-Type"]}, [response.body]]
        end
      end
    end
    result
  end

  private

  def get_response(uri)
    Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == "https") do |http|
      return http.request(Net::HTTP::Get.new(uri, "user-agent" => "curl/7.43.0"))
    end
  end
end
