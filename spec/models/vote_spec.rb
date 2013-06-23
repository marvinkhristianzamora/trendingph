require 'spec_helper'

describe Vote do
  let(:author) { FactoryGirl.create(:user) }
  let(:voter) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user: author) }
  let(:vote) { voter.votes.build(post_id: post.id) }

  subject { vote }

  describe "vote methods" do
    it { should respond_to(:user) } 
    it { should respond_to(:user_id) } 
    it { should respond_to(:post) } 
    it { should respond_to(:post_id) }
    its(:user) { should eq voter } 
    its(:post) { should eq post }

    it { should be_valid }
  end
end
