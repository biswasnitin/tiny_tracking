require 'test_helper'

class UserTrackLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_track_log = user_track_logs(:one)
  end

  test "should get index" do
    get user_track_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_user_track_log_url
    assert_response :success
  end

  test "should create user_track_log" do
    assert_difference('UserTrackLog.count') do
      post user_track_logs_url, params: { user_track_log: { user_id: @user_track_log.user_id, user_name: @user_track_log.user_name } }
    end

    assert_redirected_to user_track_log_url(UserTrackLog.last)
  end

  test "should show user_track_log" do
    get user_track_log_url(@user_track_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_track_log_url(@user_track_log)
    assert_response :success
  end

  test "should update user_track_log" do
    patch user_track_log_url(@user_track_log), params: { user_track_log: { user_id: @user_track_log.user_id, user_name: @user_track_log.user_name } }
    assert_redirected_to user_track_log_url(@user_track_log)
  end

  test "should destroy user_track_log" do
    assert_difference('UserTrackLog.count', -1) do
      delete user_track_log_url(@user_track_log)
    end

    assert_redirected_to user_track_logs_url
  end
end
