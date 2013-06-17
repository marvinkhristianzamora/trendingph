FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user_#{n}@email.com" }
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end

end
