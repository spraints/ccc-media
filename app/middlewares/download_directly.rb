class DownloadDirectly
  def initialize(app)
    @app = app
  end

  def call(env)
    result = @app.call(env)
    if bulletin = env[:download_directly]
      p result[0]
      p result[1]
      p env[:download_directly]
    end
    result
  end
end
