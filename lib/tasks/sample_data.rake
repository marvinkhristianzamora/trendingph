namespace :db do
  desc "Fill database with dummy userse"
  task populate: :environment do
    make_users
    make_posts
  end
end

def make_users
  User.create!(username: "bim",
               email: "bim@email.com",
               password: "password",
               password_confirmation: "password",
               admin: true)
  50.times do |n|
    username = Faker::Internet.user_name
    email = "sample-#{n+1}@email.com"
    password = "password"
    User.create!(username: username,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_posts
  users = User.all(limit: 10)
  10.times do
    title = Faker::Lorem.sentence
    url = "http://www.google.com"
    users.each { |user| user.posts.create!(title: title, url: url, upvote: rand(9994) + 5, hit: rand(2000)) }
  end
end
