require 'nokogiri'
require 'open-uri'
require 'watir-webdriver'

class Photo < ActiveRecord::Base
  belongs_to :page
  has_many :likes
  has_many :comments

  def self.save_photo_details(page_url, photo_details)
    photo = Photo.new
    photo.page_id = Page.find_by(url: page_url).id
    photo.url = photo_details[:url]
    photo.likes_count = photo_details[:likes_count]
    photo.description = photo_details[:description]
    photo.created_at = photo_details[:created_at]
    photo.save
    return photo.id
  end
end
