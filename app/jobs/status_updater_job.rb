class StatusUpdaterJob < ActiveJob::Base
  queue_as :default
  
#  rescue_from(StandardError) do |exception|
#    notify_failed_job_to_manager(exception)
#  end

  def perform(post_id)
 #   Post.find(post_id).check_status
  end

#   def notify_failed_job_to_manager(exception)
#    NotificationMailer.job_failed(User.find_manager, exception).deliver_later
#  end

end
