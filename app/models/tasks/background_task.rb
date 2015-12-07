module Tasks
  # Put any other task into the background.
  class BackgroundTask
    def initialize(task)
      @task = task
    end

    def perform(*args)
      Thread.new do
        begin
          @task.perform(*args)
        ensure
          ActiveRecord::Base.connection.close
        end
      end
    end
  end
end
