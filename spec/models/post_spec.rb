require 'spec_helper'

describe Post do
  let(:user) { FactoryGirl.create(:user) }
  before { @post = user.posts.build(url: "http://test.com", title: "test title", content: "test content") }

  subject { @post }

  it { should respond_to(:url) }
  it { should respond_to(:content) }
  it { should respond_to(:title) }
  it { should respond_to(:upvote) }
  it { should respond_to(:hit) }
  it { should respond_to(:user) }
  it { should respond_to(:user_id) }
  its(:user) { should eq user }
  its(:upvote) { should eq 1 }
  its(:hit) { should eq 0 }

  it { should be_valid }

  describe "author vote after create" do
    before { @post.save }
    let(:vote) { Vote.find_by(post_id: @post.id) }

    it { should be_voted_by(user) }
    it { should eq vote.post } 
    its(:user) { vote.user }
  end

end
