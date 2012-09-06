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
    before { visit new_volunteer_path }

    it { should have_selector('h1',    text: 'Registo de Voluntários') }
    it { should have_selector('title', text: full_title('Registo de Voluntários')) }
  end

  describe "signup" do

    before { visit new_volunteer_path }

    let(:submit) { "Criar conta" }

    describe "with invalid information" do
      
      it "should not create a volunteer" do
        expect { click_button submit }.not_to change(Volunteer, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Registo') }
        it { should have_content('erro') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Nome",                 with: "Example User"
        fill_in "Email",                with: "user@example.com"
        fill_in "Username",             with: "exampleuser"
        fill_in "Password",             with: "foobar"
        fill_in "Confirmação Password", with: "foobar"
      end

      it "should create a volunteer" do
        expect { click_button submit }.to change(Volunteer, :count).by(1)
      end

      describe "after saving the volunteer" do
        before { click_button submit }
        let(:volunteer) { Volunteer.find_by_email('user@example.com') }

        it { should have_selector('title', text: volunteer.name) }
        it { should have_selector('div.alert.alert-success', text: 'Bem-vindo') }
        it { should have_link('Sign out') }
      end
    end
  end
end
