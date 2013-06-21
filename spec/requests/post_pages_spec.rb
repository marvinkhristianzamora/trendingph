require 'spec_helper'

describe "PostPages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  describe "new post page" do
    before do
      valid_signin user 
      visit new_post_path
    end

    it { should have_title("Submit") }
  end

  describe "post creation" do
    before do
      valid_signin user 
      visit new_post_path
    end

    describe "with invalid information" do
      it "should not create new post" do
        expect { click_button "Submit" }.not_to change(Post, :count)
      end
    end

    describe "error message" do
      before { click_button "Submit" }

      it { should have_content("error") }
    end
  end

  describe "post index" do

    describe "list" do
      let!(:post1) { FactoryGirl.create(:post, user: user, url: "http://url1.com",
                                       title: "Title1", upvote: 10 ) }
      let!(:post2) { FactoryGirl.create(:post, user: user, url: "http://url2.com",
                                       title: "Title2", upvote: 20 ) }
      before do
        @posts = Post.all.to_a
        puts Post.all.to_a
        visit root_path
      end

      it "should have saved posts" do
        @posts.each do |post|
          expect(page).to have_link(post.title, href: post.url)
          expect(page).to have_link(post.user.username, href: user_path(post.user))
          expect(page).to have_content(post.upvote)
        end
      end
    end
  end
end
