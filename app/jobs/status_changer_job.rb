class StatusChangerJob < ActiveJob::Base
  queue_as :default

  def perform()
       @posts = Post.where("(status = ? OR status = ?) AND when_date < ?", 0, 1, Date.today)
       @posts.each do |post|
       #Post.find_each do |post|
          if post.status == 'pending'
            # More than 0 bids and the auction has ended
            post.update_attribute :status, 'complete'
            Rails.logger.debug "#{self.class.name}: changed status to complete"
            # update_attribute(post.status, 'complete')
          elsif post.status == 'open'
            # 0 bids and the auction has ended
            post.update_attribute :status, 'incomplete'
            Rails.logger.debug "#{self.class.name}: changed status to incomplete"
        end
     end
   end
end
