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
end
