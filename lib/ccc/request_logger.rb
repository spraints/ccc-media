require "useragent"

module CCC
  class RequestLogger
    def initialize(app)
      @app = app
    end

    def call(env)
      start = Time.now.to_f
      begin
        @app.call(env)
      ensure
        duration = Time.now.to_f - start
        useragent = env["HTTP_USER_AGENT"]
        ua = UserAgent.parse(useragent)
        Rails.logger.info "method=#{env["REQUEST_METHOD"].inspect} path=#{env["PATH_INFO"].inspect} duration=#{'%0.4f' % duration} os=#{ua.os.to_s.inspect} user_agent=#{useragent.inspect}"
      end
    end
  end
end
