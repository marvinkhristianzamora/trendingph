FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user_#{n}@email.com" }
    karma 1
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end
  
  factory :post do
    url "http://test.com"
    title "test post"
    content "test post text"
    upvote 1
    hit 0
    user
  end

end
