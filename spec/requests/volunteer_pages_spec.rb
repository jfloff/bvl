#encoding: utf-8

require 'spec_helper'

describe "Volunteer pages" do

  subject { page }

  describe "profile page" do
    let(:volunteer) { FactoryGirl.create(:volunteer) }
    before { visit volunteer_path(volunteer) }

    it { should have_selector('h1',    text: volunteer.name) }
    it { should have_selector('title', text: "#{volunteer.name} (#{volunteer.username})") }
  end

  describe "signup page" do
    before { visit volunteer_signup_path }

    it { should have_selector('h1',    text: 'Registo de Voluntários') }
    it { should have_selector('title', text: full_title('Registo de Voluntários')) }
  end
end
