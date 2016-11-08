class StatusChangerJob < ActiveJob::Base
  queue_as :default

  def perform()
      Post.find_each(&:update_status)
  end
end
