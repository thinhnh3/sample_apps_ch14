require "test_helper"

class RelationshipBroadcastJobTest < ActiveJob::TestCase
  def setup
    @follower = users(:michael)
    @followed = users(:archer)
    @relationship = Relationship.new(follower_id: @follower.id,
                                     followed_id: @followed.id)
    @relationship.save
  end

  test "send notification" do
    RelationshipBroadcastJob.set(wait: 5.minutes).perform_later(@relationship, @follower.name)
    assert_enqueued_jobs 2
    assert_performed_jobs 0
  end

  test "perform send notification" do
    perform_enqueued_jobs do
      RelationshipBroadcastJob.set(wait: 5.minutes).perform_later(@relationship, @follower.name)
    end
    assert_performed_jobs 1
  end
end
