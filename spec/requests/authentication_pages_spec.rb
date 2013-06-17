require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }
    it { should have_title("Sign in") }
    it { should have_content("Sign in") }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title("Sign in") }
      it { should have_content("Invalid") }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title("TrendingPH") }
      it { should have_link("Sign out", href: signout_path) }
      it { should have_link(user.username) }
      it { should_not have_link("Sign in") }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_success_message("Successfully signed out.")}
        it { should have_link("Sign in", href: signin_path) }
        it { should_not have_link("Sign out") }
      end
    end
  end

end
