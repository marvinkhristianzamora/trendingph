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

end
