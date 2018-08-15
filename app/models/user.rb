require 'nokogiri'   
require 'open-uri'

class User < ActiveRecord::Base
  has_many :comments, dependent: :delete_all
  has_many :likes

  scope :all_users_related_to_profile, -> (id) { joins(:comments => [:photo => [:page => :my_profile]]).where('my_profile_id = ?', id) }
  scope :good_to_follow, -> (account, limit) { where("latest_hashtags RLIKE (?) or biography RLIKE (?)", account.related_hashtags.gsub(' ','|'), account.related_hashtags.gsub(' ','|')).where("users.followings_count < 600").where("users.is_followed is NOT true").limit(limit) }

  scope :without_posts, -> { where('posts_count <= ?', 2) }
  scope :with_more_than_1k_following, -> { where('followings_count > ?', 1000) }
  scope :with_more_than_6k_followers, -> { where('followers_count > ?', 6000) }
  scope :with_more_than_20_comments, -> { where('comments_count >= ?', 20) }
  scope :with_many_posts_no_hashtags, -> { where('posts_count >= ?', 1000).where(hashtags: '') }
  scope :many_posts_no_hashtags, -> { where('posts_count >= ?', 1800).where(hashtags: '') }
  scope :commented_with_only_emojis, -> { where('id in (?)', Comment.where(content: '').pluck(:user_id).uniq) }

  def increment_comments
    self.comments_count += 1
    save!
  end

  def self.fetch_user_details(users)
    users.each do |user|
      profile = Nokogiri::HTML(open("#{user.profile_url}"))
      profile = eval(profile.text.split("window._sharedData")[1].split("window.__")[0].split("!function")[0][3..-1].gsub!('null', 'nil'))
      profile = profile[:entry_data][:ProfilePage][0][:graphql][:user]
      website = profile[:external_url].nil? ? '' : profile[:external_url] 
      biography = (profile[:biography] + website).encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
      hashtags = []
      profile[:edge_owner_to_timeline_media][:edges][0..12].each do |photo_details|
        if !photo_details[:node][:edge_media_to_caption][:edges][0].nil?
          hashtags += photo_details[:node][:edge_media_to_caption][:edges][0][:node][:text].encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').scan(/#\w+/).flatten
        end
      end
      user.biography = biography
      user.is_private = profile[:is_private]
      user.latest_hashtags = hashtags.uniq.join(' ')
      user.posts_count = profile[:edge_owner_to_timeline_media][:count]
      user.followers_count = profile[:edge_followed_by][:count]
      user.followings_count = profile[:edge_follow][:count]
      user.save!
      sleep(rand(5..12))
    end
  end

  def self.delete_unwanted_users
    User.without_posts.delete_all
    User.with_more_than_1k_following.delete_all
    User.with_more_than_6k_followers.delete_all
    User.with_more_than_20_comments.delete_all
    User.commented_with_only_emojis.delete_all
  end
end
