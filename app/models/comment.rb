class Comment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user

  def self.save_photos_comments(photos_comments)
    photos_comments.each do |photo_comments|
      user = User.find_by(profile_url: photo_comments[:profile_url])
      if user.nil?
        user = User.create(profile_url: photo_comments[:profile_url], like_count: 0, comments_count: 1)
      else
        user.increment_comments
      end
      Comment.create(user_id: user.id, photo_id: photo_comments[:photo_id], content: photo_comments[:comment_content])
    end
  end
end
