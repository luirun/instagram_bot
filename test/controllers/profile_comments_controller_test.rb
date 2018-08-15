require 'test_helper'

class ProfileCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_comment = profile_comments(:one)
  end

  test "should get index" do
    get profile_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_comment_url
    assert_response :success
  end

  test "should create profile_comment" do
    assert_difference('ProfileComment.count') do
      post profile_comments_url, params: { profile_comment: { content: @profile_comment.content, profile_id: @profile_comment.profile_id, related_hashtags: @profile_comment.related_hashtags } }
    end

    assert_redirected_to profile_comment_url(ProfileComment.last)
  end

  test "should show profile_comment" do
    get profile_comment_url(@profile_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_comment_url(@profile_comment)
    assert_response :success
  end

  test "should update profile_comment" do
    patch profile_comment_url(@profile_comment), params: { profile_comment: { content: @profile_comment.content, profile_id: @profile_comment.profile_id, related_hashtags: @profile_comment.related_hashtags } }
    assert_redirected_to profile_comment_url(@profile_comment)
  end

  test "should destroy profile_comment" do
    assert_difference('ProfileComment.count', -1) do
      delete profile_comment_url(@profile_comment)
    end

    assert_redirected_to profile_comments_url
  end
end
