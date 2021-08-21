require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  # test "connects with cookies" do
  #   cookies.signed[:user_id] = 42
  #
  #   connect
  #
  #   assert_equal connection.user_id, "42"
  # end
  def setup
    @user = users(:michael)
  end

  # test "connects with session" do
  #   log_in_as(@user)
  #   connect session: { user_id: @user.id }
  #   assert_equal connection.user_id, @user.id
  # end

  test "rejects connection without params" do
    assert_reject_connection { connect }
  end
end
