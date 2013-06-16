require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
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
      it { should have_link("Sign out") }
      it { should have_link(user.name) }
      it { should_not have_link("Sign in") }
    end
  end
end
