require 'spec_helper'

describe "StaticPages" do

  let(:title) { 'newsmakersPH' }
  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_content(heading) }
    it { should have_title(page_title) }
    it { should have_link("SUBMIT") }
    it { should have_link("Sign in") }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { "#{title}" }
    let(:page_title) { "" }

    it_should_behave_like "all static pages"
  end
end
