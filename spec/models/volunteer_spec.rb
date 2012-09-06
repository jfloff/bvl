#encoding: utf-8

# == Schema Information
#
# Table name: volunteers
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe Volunteer do

  before do
    @volunteer = Volunteer.new(username: "exampleuser", name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @volunteer }

  it { should respond_to(:username) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  describe "when name is not present" do
    before { @volunteer.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @volunteer.email = " " }
    it { should_not be_valid }
  end

  describe "when username is not present" do
    before { @volunteer.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @volunteer.username = "a" * 16 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @volunteer.email = invalid_address
        @volunteer.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @volunteer.email = valid_address
        @volunteer.should be_valid
      end      
    end
  end

  describe "when email address is already taken from a volunteer" do
    before do
      volunteer_with_same_email = @volunteer.dup
      volunteer_with_same_email.email = @volunteer.email.upcase
      volunteer_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken from a entity" do
    let(:entity) { FactoryGirl.create(:entity) }
    
    before do
      @volunteer.email = entity.email
      @volunteer.save
      volunteer_with_same_email = @volunteer.dup
      volunteer_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @volunteer.email = mixed_case_email
      @volunteer.save
      @volunteer.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "when username format is invalid" do
    it "should be invalid" do
      usernames = %w[foo-bar foo?bar exa.mple foo:bar]
      usernames.each do |invalid_username|
        @volunteer.username = invalid_username
        @volunteer.should_not be_valid
      end      
    end
  end

  describe "when username format is valid" do
    it "should be valid" do
      usernames = %w[foobar 1foobar2 foo_bar foo_bar_2 _1 f 1 _]
      usernames.each do |valid_username|
        @volunteer.username = valid_username
        @volunteer.should be_valid
      end      
    end
  end

  describe "when username is already taken" do
    before do
      volunteer_with_same_username = @volunteer.dup
      volunteer_with_same_username.username = @volunteer.username.upcase
      volunteer_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when username is already taken from a entity" do
    let(:entity) { FactoryGirl.create(:entity) }
    
    before do
      @volunteer.username = entity.username
      @volunteer.save
      volunteer_with_same_username = @volunteer.dup
      volunteer_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "username with mixed case" do
    let(:mixed_case_username) { "ExAmPlEuSeR" }

    it "should be saved as all lower-case" do
      @volunteer.username = mixed_case_username
      @volunteer.save
      @volunteer.reload.username.should == mixed_case_username.downcase
    end
  end

  describe "when password is not present" do
    before { @volunteer.password = @volunteer.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @volunteer.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @volunteer.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @volunteer.password = @volunteer.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @volunteer.save }
    let(:found_volunteer) { Volunteer.find_by_email(@volunteer.email) }

    describe "with valid password" do
      it { should == found_volunteer.authenticate(@volunteer.password) }
    end

    describe "with invalid password" do
      let(:volunteer_for_invalid_password) { found_volunteer.authenticate("invalid") }

      it { should_not == volunteer_for_invalid_password }
      specify { volunteer_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @volunteer.save }
    its(:remember_token) { should_not be_blank }
  end
end
