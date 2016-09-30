class StatusChangerJob < ActiveJob::Base
  queue_as :default

  def perform(post)
    post.check_status
  end
end
