# == Schema Information
#
# Table name: entities
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

describe Entity do

  before { @entity = Entity.new(username: "exampleuser", name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @entity }

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
    before { @entity.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @entity.email = " " }
    it { should_not be_valid }
  end

  describe "when username is not present" do
    before { @entity.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @entity.username = "a" * 16 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @entity.email = invalid_address
        @entity.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @entity.email = valid_address
        @entity.should be_valid
      end      
    end
  end

  describe "when email address is already taken form another entity" do
    before do
      entity_with_same_email = @entity.dup
      entity_with_same_email.email = @entity.email.upcase
      entity_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken from a volunteer" do
    let(:volunteer) { FactoryGirl.create(:volunteer) }
    
    before do
      @entity.email = volunteer.email
      @entity.save
      entity_with_same_email = @entity.dup
      entity_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @entity.email = mixed_case_email
      @entity.save
      @entity.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "when username format is invalid" do
    it "should be invalid" do
      usernames = %w[foo-bar foo?bar exa.mple foo:bar]
      usernames.each do |invalid_username|
        @entity.username = invalid_username
        @entity.should_not be_valid
      end      
    end
  end

  describe "when username format is valid" do
    it "should be valid" do
      usernames = %w[foobar 1foobar2 foo_bar foo_bar_2 _1 f 1 _]
      usernames.each do |valid_username|
        @entity.username = valid_username
        @entity.should be_valid
      end      
    end
  end

  describe "when username is already taken from another entity" do
    before do
      entity_with_same_username = @entity.dup
      entity_with_same_username.username = @entity.username.upcase
      entity_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when username is already taken from a volunteer" do
    let(:volunteer) { FactoryGirl.create(:volunteer) }
    
    before do
      @entity.username = volunteer.username
      @entity.save
      entity_with_same_username = @entity.dup
      entity_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "username with mixed case" do
    let(:mixed_case_username) { "ExAmPlEuSeR" }

    it "should be saved as all lower-case" do
      @entity.username = mixed_case_username
      @entity.save
      @entity.reload.username.should == mixed_case_username.downcase
    end
  end

  describe "when password is not present" do
    before { @entity.password = @entity.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @entity.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @entity.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @entity.password = @entity.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @entity.save }
    let(:found_entity) { Entity.find_by_email(@entity.email) }

    describe "with valid password" do
      it { should == found_entity.authenticate(@entity.password) }
    end

    describe "with invalid password" do
      let(:entity_for_invalid_password) { found_entity.authenticate("invalid") }

      it { should_not == entity_for_invalid_password }
      specify { entity_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @entity.save }
    its(:remember_token) { should_not be_blank }
  end
end
