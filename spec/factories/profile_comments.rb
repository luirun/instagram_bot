FactoryBot.define do
  factory :profile_comment do
    profile_id 1
    content "To jest testowy {comment|komentarz} możesz to sprawdzić {siostra|brat|tata|mama}!"
    related_hashtags "test,gitara,test"
  end
end