require 'watir'
require 'open-uri'
require 'nokogiri'

class InstagramService

  def self.fetch_page_details(profile)
    page = Nokogiri::HTML(open("#{profile.url}"))
    page = eval(page.text.split("window._sharedData")[1].split("window.__")[0].split("!function")[0][3..-1].gsub!('null', 'nil'))
    page = page[:entry_data][:ProfilePage][0][:graphql][:user]
    id = profile.id
    if profile.class.name.demodulize == "MyProfile" 
      profile = MyProfileStatistic.new
      profile.profile_id = id
    end
    profile.posts_count = page[:edge_owner_to_timeline_media][:count]
    profile.followers_count = page[:edge_followed_by][:count]
    profile.followings_count = page[:edge_follow][:count]
    profile.save
  end

  def self.like_and_follow_users(account, limit)
    browser = account.login
    users = User.all_users_related_to_profile(account.id).good_to_follow(account, limit)
    users.each do |user|
      browser.goto(user.profile_url)
      photos = browser.divs(class: "_mck9w")
      i = 0
      photos[0..24].each do |photo|
        photo.click
        sleep(1)
        if !browser.elements(css: "li._ezgzd")[0].exists? then browser.element(class: "_dcj9f").click; next end
        description = browser.elements(css: "li._ezgzd")[0].text.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').split(' ')[1..-1].join(' ')
        if account.related_hashtags.gsub(/#/,'').split(' ').any? { |word| description.include?(word) }
          browser.element(class: '_eszkz').click
          post_comment(browser, account, description) if i == 0
          i += 1
          sleep(1)
        end
        browser.element(class: "_dcj9f").click
        sleep(rand(1..3))
        break if i == 2
      end
      browser.send_keys :home
      sleep(0.5)
      if i != 0 then browser.element(class: '_qv64e').click end
      sleep(rand(2..4))
      user.is_followed = true
      user.save
      sleep(rand(45..80))
    end
    browser.close
  end

  def self.unfollow_people(account)
    browser = account.login
    browser.goto(account.url)
    browser.element(class: '_t98z6', index: 2).click
    sleep(2)
    browser.element(class: '_6e4x5').click
    sleep(1)
    for i in 1..15 do
      browser.send_keys :end
      sleep(0.5)
    end
    browser.send_keys :home
    sleep(2)
    browser.elements(class: '_6e4x5').each do |e|
      e.scroll.to
      e.element(class: '_qv64e').click
      sleep(rand(45..68))
    end
    browser.close
  end

  def self.post_comment(browser, account, description)
    comments =  account.comments.related_to_photo_description(description[0..350].gsub(/\d+/,"").gsub('|','').gsub('+','').gsub('?','').gsub('(','').gsub('*','').gsub(/\s+/," ").strip)
    if !comments.empty?
      sleep(rand(6..15))
      comment = comments.sample.spin
      browser.textarea(:aria_label => 'Add a comment…').set(comment)
      sleep(0.5)
      browser.form(class: '_b6i0l').submit
      sleep(0.5)
    end
  end

  def self.post_image(account, image = nil)
    driver = Selenium::WebDriver.for :chrome, :switches => %w[--user-agent=Mozilla/5.0\ (iPhone;\ CPU\ iPhone\ OS\ 5_0\ like\ Mac\ OS\ X)\ AppleWebKit/534.46\ (KHTML,\ like\ Gecko)\ Version/5.1\ Mobile/9A334\ Safari/7534.48.3]
    browser = Watir::Browser.new driver
    account.login(browser)
    sleep(1)
    browser.goto('http://instagram.com')
    sleep(2)
    puts browser.element(class: '_k0d2z').exists?
    browser.element(class: '_k0d2z').fire_event :click
    browser.element(class: '_crp8c').fire_event('onClick')
    browser.element(class: '_crp8c').fire_event('click')
    browser.element(class: '_k0d2z').click
    #browser.file_field(class: '_k0d2z').set("G:\\$$$\\instagramy\\fashion\\1.jpg")
    sleep(5)
    browser.goto('https://encodable.com/uploaddemo/')
    browser.element(id: 'uploadname1').click
  end

end