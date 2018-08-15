require "application_system_test_case"

class ProfileCommentsTest < ApplicationSystemTestCase
  setup do
    @profile_comment = profile_comments(:one)
  end

  test "visiting the index" do
    visit profile_comments_url
    assert_selector "h1", text: "Profile Comments"
  end

  test "creating a Profile comment" do
    visit profile_comments_url
    click_on "New Profile Comment"

    fill_in "Content", with: @profile_comment.content
    fill_in "Profile", with: @profile_comment.profile_id
    fill_in "Related Hashtags", with: @profile_comment.related_hashtags
    click_on "Create Profile comment"

    assert_text "Profile comment was successfully created"
    click_on "Back"
  end

  test "updating a Profile comment" do
    visit profile_comments_url
    click_on "Edit", match: :first

    fill_in "Content", with: @profile_comment.content
    fill_in "Profile", with: @profile_comment.profile_id
    fill_in "Related Hashtags", with: @profile_comment.related_hashtags
    click_on "Update Profile comment"

    assert_text "Profile comment was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile comment" do
    visit profile_comments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile comment was successfully destroyed"
  end
end
