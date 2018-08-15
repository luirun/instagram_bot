FactoryBot.define do
  factory :user do
    profile_url "https://www.instagram.com/test"
    like_count 1
    comments_count 2
    followers_count 23
    followings_count 1973
    posts_count 13
    is_private false
    biography "Sample description"
    is_followed true
  end
end