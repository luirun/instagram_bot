class ProfileComment < ApplicationRecord
  belongs_to :my_profile

  scope :pick_random, -> (profile) { where(profile_id: profile.id).sample }
  scope :related_to_photo_description, -> (description) { where("related_hashtags RLIKE (?)", description.gsub(' ','|')) }

  def spin
    options = content.scan(/(?<={).*?(?=})/)
    spinned_content = content.split(/(?={).*?(?<=})/)
    options.each_with_index do |option, key|
      options[key] = option.split('|').sample
      spinned_content[key] << options[key]
    end
    spinned_content.join('').gsub(/\s+/, ' ')
  end

end