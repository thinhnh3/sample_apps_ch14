class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :send_notification

  def send_notification
    relationships = Relationship.where('followed_id = :followed_id AND created_at >= :created_at', followed_id: self.followed_id, created_at: 5.minutes.ago)
    if relationships.count == 1
      user_name = User.find(self.follower_id).name
      RelationshipBroadcastJob.set(wait: 5.minutes).perform_later(self, user_name)
    end
  end
end