require 'test_helper'

class MyProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_profile = my_profiles(:one)
  end

  test "should get index" do
    get my_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_my_profile_url
    assert_response :success
  end

  test "should create my_profile" do
    assert_difference('MyProfile.count') do
      post my_profiles_url, params: { my_profile: { password: @my_profile.password, url: @my_profile.url, username: @my_profile.username } }
    end

    assert_redirected_to my_profile_url(MyProfile.last)
  end

  test "should show my_profile" do
    get my_profile_url(@my_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_profile_url(@my_profile)
    assert_response :success
  end

  test "should update my_profile" do
    patch my_profile_url(@my_profile), params: { my_profile: { password: @my_profile.password, url: @my_profile.url, username: @my_profile.username } }
    assert_redirected_to my_profile_url(@my_profile)
  end

  test "should destroy my_profile" do
    assert_difference('MyProfile.count', -1) do
      delete my_profile_url(@my_profile)
    end

    assert_redirected_to my_profiles_url
  end
end
