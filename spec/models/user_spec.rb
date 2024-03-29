require 'spec_helper'

describe User do

  before { @user = User.new(username: "Test User", email: "test@email.com",
                           password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:karma) }

  it { should be_valid }
  it { should_not be_admin }

  describe "when admin flag is set to true" do
    before do
      @user.save!
      @user.toggle!(:admin)

      it { should be_admin }
    end
  end

  describe "when username is not present" do
    before { @user.username = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "x" * 21 }
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      duplicate_username_user = @user.dup
      duplicate_username_user.save
    end

    it { should_not be_valid }
  end

  describe "when email is valid" do
    it "should be valid" do
      valid_addresses = %w[username@email.com username-123@Email.com.ph a-b@goog.COM]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is invalid" do
    it "should be invalid" do
      invalid_addresses = %w[user@foo*.com noatsign.com user@foo. user@foo_d.com foo@barz]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do 
      duplicate_email_user = @user.dup
      duplicate_email_user.email = @user.email.upcase
      duplicate_email_user.save
    end

    it { should_not be_valid }
  end

  describe "when email address is in mixed case" do
    let(:mixed_case_email) { "TeSt@EmAiL.cOm" }

    it "should be saved as all lower case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "when password is empty" do
    before do
      @user = User.new(username: "Test User", email: "test@email.com",
                       password: " ", password_confirmation: " ")
    end

    it { should_not be_valid }
  end

  describe "when password and password confirmation is mismatched" do
    before { @user.password_confirmation = "mismatched" }

    it { should_not be_valid }
  end

  describe "when password_confirmation is nil" do
    before do
      @user = User.new(username: "Test User", email: "test@email.com",
                       password: "password", password_confirmation: nil)
    end

    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
      
    describe "with incorrect password" do
      let(:unauthorized_user) { found_user.authenticate("invalid") }
      it { should_not eq unauthorized_user }
      specify { expect(unauthorized_user).to be_false } 
    end
  end

  describe "with a password that is too short" do
    before { @user.password = @user.password_confirmation = "x" * 5 }

    it { should_not be_valid }
  end

  describe "remember token" do 
    before { @user.save }

    its(:remember_token) { should_not be_blank }
  end

end

