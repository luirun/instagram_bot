require 'nokogiri'   
require 'open-uri'

class Page < ActiveRecord::Base
  belongs_to :my_profile
  has_many :photos

  def self.fetch_pages_photos_comments(pages_urls)
    browser = Watir::Browser.new :chrome
    comments_hash = []
    pages_urls.each do |page_url|
      homepage = page_url
      browser.goto(homepage)
      photos = browser.divs(class: "v1Nh3")
      photos[0..4].each do |photo|
        photo_details = { url: photo.link.href }
        browser.goto(photo_details[:url])
        sleep(5)
        photo_details[:likes_count] = browser.element(css: "span.zV_Nj").span.text.split(',').join('').to_i
        # if !browser.elements(css: "li._ezgzd")[0].exists? then browser.element(class: "_dcj9f").click; next end
        photo_details[:description] = browser.elements(css: "li.gElp9")[0].text.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
        photo_details[:created_at] = browser.element(css: "a.c-Yi7").time.attribute_value "datetime"
        break unless Photo.find_by(created_at: photo_details[:created_at]).nil?
        photo_id = Photo.save_photo_details(page_url, photo_details)
        loop do
          browser.element(css: "a._m3m1c").click if browser.element(css: "a._m3m1c").exists?
          sleep(0.5)
          break unless browser.element(css: "a._m3m1c").exists?
        end
        comments = browser.element(css: "ul.Xl2Pu").elements(css: "li.gElp9")
        comments.each do |comment|
          comments_hash << { profile_url: comment.a.href, comment_content: comment.span.text.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''), photo_id: photo_id }
        end
        browser.goto(homepage)
        sleep(3)
      end
      sleep(5)
    end
    browser.close
    return comments_hash
  end

end

#source to photo thumbnail
#ig_page[:edges][3][:node][:thumbnail_src]
