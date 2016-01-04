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
        response = Net::HTTP.get_response(uri)
        if response.is_a?(Net::HTTPRedirection)
          location = response["Location"]
        else
          return [200, {"Content-Type" => response["Content-Type"]}, [response.body]]
        end
      end
    end
    result
  end
end
