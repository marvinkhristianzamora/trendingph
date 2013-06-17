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
end
