class RelationshipsChannel < ApplicationCable::Channel
  def self.broadcast(relationship)
    broadcast_to "relationships:#{relationship.followed_id}", { user_name: relationship.follower_id }
  end
  
  def subscribed
    stream_from "relationships:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
