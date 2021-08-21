require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get first login" do
    log_in_as(@user)
    assert_equal flash[:info], "初回ログインありがとうございます。"
    assert_redirected_to user_path(@user)
  end

  test "should get second login" do
    @user.update_sign_in_count
    log_in_as(@user)
    assert flash.empty?
    assert_redirected_to user_path(@user)
  end
end
