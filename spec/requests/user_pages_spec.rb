require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "signup" do
    before { visit signup_path }

    it { should have_content("Sign up") }
    it { should have_title("Sign up") }

    describe "with invalid info" do
      it "should not create new user" do
        expect { click_button "Create account" }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button "Create account" }

        it { should have_content("errors") }
        it { should have_title("Sign up") }
      end
    end

    describe "with valid info" do
      before do
        fill_in "Username", with: "test"
        fill_in "Email", with: "test@email.com"
        fill_in "Password", with: "password"
        fill_in "Confirm Password", with: "password"
      end
      
      it "should create new user" do
        expect { click_button "Create account" }.to change(User, :count).by(1)
      end

      describe "after submission" do
        let(:user) { User.find_by(username: "test") }
        before do
          click_button "Create account"
        end
        it { should have_link("Sign out", href: signout_path) }
        it { should have_title("newsmakersPH") }
        it { should have_link("Profile", href: user_path(user)) }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_title(user.username) }
    it { should have_content(user.username) }
  end
end
