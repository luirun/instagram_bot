class MyProfile < ApplicationRecord
  has_many :statistics, foreign_key: "profile_id", class_name: "MyProfileStatistic"
  has_many :comments, foreign_key: "profile_id", class_name: "ProfileComment"
  has_many :pages

  def login(browser=nil)
    browser = Watir::Browser.new :chrome if browser.nil?
    browser.goto("https://www.instagram.com/accounts/login/")
    sleep(2)
    browser.text_field(class: '_ph6vk', index: 0).set(username)
    sleep(0.5)
    browser.text_field(class: '_ph6vk', index: 1).set(password)
    sleep(0.5)
    browser.form(:class, '_3jvtb').submit
    sleep(6)
    return browser
  end
end
