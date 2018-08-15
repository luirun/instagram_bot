require "application_system_test_case"

class MyProfilesTest < ApplicationSystemTestCase
  setup do
    @my_profile = my_profiles(:one)
  end

  test "visiting the index" do
    visit my_profiles_url
    assert_selector "h1", text: "My Profiles"
  end

  test "creating a My profile" do
    visit my_profiles_url
    click_on "New My Profile"

    fill_in "Password", with: @my_profile.password
    fill_in "Url", with: @my_profile.url
    fill_in "Username", with: @my_profile.username
    click_on "Create My profile"

    assert_text "My profile was successfully created"
    click_on "Back"
  end

  test "updating a My profile" do
    visit my_profiles_url
    click_on "Edit", match: :first

    fill_in "Password", with: @my_profile.password
    fill_in "Url", with: @my_profile.url
    fill_in "Username", with: @my_profile.username
    click_on "Update My profile"

    assert_text "My profile was successfully updated"
    click_on "Back"
  end

  test "destroying a My profile" do
    visit my_profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "My profile was successfully destroyed"
  end
end
