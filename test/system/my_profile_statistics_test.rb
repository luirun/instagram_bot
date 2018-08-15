require "application_system_test_case"

class MyProfileStatisticsTest < ApplicationSystemTestCase
  setup do
    @my_profile_statistic = my_profile_statistics(:one)
  end

  test "visiting the index" do
    visit my_profile_statistics_url
    assert_selector "h1", text: "My Profile Statistics"
  end

  test "creating a My profile statistic" do
    visit my_profile_statistics_url
    click_on "New My Profile Statistic"

    fill_in "Followers Count", with: @my_profile_statistic.followers_count
    fill_in "Followings Count", with: @my_profile_statistic.followings_count
    fill_in "Post Count", with: @my_profile_statistic.post_count
    fill_in "Profile", with: @my_profile_statistic.profile_id
    click_on "Create My profile statistic"

    assert_text "My profile statistic was successfully created"
    click_on "Back"
  end

  test "updating a My profile statistic" do
    visit my_profile_statistics_url
    click_on "Edit", match: :first

    fill_in "Followers Count", with: @my_profile_statistic.followers_count
    fill_in "Followings Count", with: @my_profile_statistic.followings_count
    fill_in "Post Count", with: @my_profile_statistic.post_count
    fill_in "Profile", with: @my_profile_statistic.profile_id
    click_on "Update My profile statistic"

    assert_text "My profile statistic was successfully updated"
    click_on "Back"
  end

  test "destroying a My profile statistic" do
    visit my_profile_statistics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "My profile statistic was successfully destroyed"
  end
end
