require 'test_helper'

class MyProfileStatisticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_profile_statistic = my_profile_statistics(:one)
  end

  test "should get index" do
    get my_profile_statistics_url
    assert_response :success
  end

  test "should get new" do
    get new_my_profile_statistic_url
    assert_response :success
  end

  test "should create my_profile_statistic" do
    assert_difference('MyProfileStatistic.count') do
      post my_profile_statistics_url, params: { my_profile_statistic: { followers_count: @my_profile_statistic.followers_count, followings_count: @my_profile_statistic.followings_count, post_count: @my_profile_statistic.post_count, profile_id: @my_profile_statistic.profile_id } }
    end

    assert_redirected_to my_profile_statistic_url(MyProfileStatistic.last)
  end

  test "should show my_profile_statistic" do
    get my_profile_statistic_url(@my_profile_statistic)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_profile_statistic_url(@my_profile_statistic)
    assert_response :success
  end

  test "should update my_profile_statistic" do
    patch my_profile_statistic_url(@my_profile_statistic), params: { my_profile_statistic: { followers_count: @my_profile_statistic.followers_count, followings_count: @my_profile_statistic.followings_count, post_count: @my_profile_statistic.post_count, profile_id: @my_profile_statistic.profile_id } }
    assert_redirected_to my_profile_statistic_url(@my_profile_statistic)
  end

  test "should destroy my_profile_statistic" do
    assert_difference('MyProfileStatistic.count', -1) do
      delete my_profile_statistic_url(@my_profile_statistic)
    end

    assert_redirected_to my_profile_statistics_url
  end
end
