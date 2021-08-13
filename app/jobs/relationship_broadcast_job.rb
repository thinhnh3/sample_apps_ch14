class RelationshipBroadcastJob < ApplicationJob
  queue_as :default

  def perform(relationship, user_name)
    message = "#{user_name}さんにフォローされました"
    
    relationships = Relationship.where('followed_id = :followed_id AND created_at >= :created_at', followed_id: relationship.followed_id, created_at: 5.minutes.ago)
    if relationships.count > 1
      message = "#{user_name}さん他3名にフォローされました"
    end

    ActionCable.server.broadcast "relationships:#{relationship.followed_id}", { message: message }
  end
end
