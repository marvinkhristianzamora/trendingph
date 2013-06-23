class Post < ActiveRecord::Base
  belongs_to :user

  has_many :votes

  after_save :add_author_vote

  validates :user_id, presence: true
  validates :url, presence: true
  validates :title, presence: true
  GRAVITY = 1.5

  def self.list
    if Rails.env.production?
      time = "(EXTRACT(EPOCH FROM CURRENT_TIMESTAMP - created_at)/3600)"
      denom = "(#{time}+2)^#{GRAVITY}"
    else
      time = "((strftime('%s', '2013-06-22 16:23:00') - strftime('%s', created_at))/3600)"
      denom = "(#{time}+2)*(#{time}*(#{GRAVITY}-1))"
    end
    score_query = "(upvote -1 + hit*.5)/(#{denom})"

    order("#{score_query} DESC")
  end

  private
    def add_author_vote
      self.votes.create(user: self.user)
    end
end
