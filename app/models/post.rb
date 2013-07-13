class Post < ActiveRecord::Base
  belongs_to :user

  has_many :votes

  after_create :add_author_vote

  validates :user_id, presence: true
  validates :url, presence: true
  validates :title, presence: true
  GRAVITY = 1.5

  def voted_by?(user)
    self.votes.find_by(user_id: user.id)
  end

  def vote_from!(user)
    self.votes.create!(user_id: user.id)
    self.increment!(:upvote)
  end

  def self.list
    if Rails.env.production?
      time = "(EXTRACT(EPOCH FROM CURRENT_TIMESTAMP - created_at)/3600)"
      denom = "(#{time}+2)^#{GRAVITY}"
    else
      time = "((strftime('%s', current_timestamp) - strftime('%s', created_at))/3600)"
      denom = "(#{time}+2)*(#{time}*(#{GRAVITY}-1))"
    end
    score_query = "(upvote -1)/(#{denom})"

    order("#{score_query} DESC")
  end

  private
    def add_author_vote
      self.votes.create(user: self.user)
    end
end
