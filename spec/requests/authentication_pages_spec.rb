#encoding: utf-8

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'inválido') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "volunteer" do
      let(:volunteer) { FactoryGirl.create(:volunteer) }

      describe "with valid email" do 
        before do
          fill_in "Email/Username",    with: volunteer.email
          fill_in "Password", with: volunteer.password
          click_button "Sign in"
        end

        it { should have_selector('title', text: volunteer.name) }
        it { should have_link('Perfil', href: volunteer_path(volunteer)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end

      describe "with valid username" do
        before do
          fill_in "Email/Username",    with: volunteer.username
          fill_in "Password", with: volunteer.password
          click_button "Sign in"
        end

        it { should have_selector('title', text: volunteer.name) }
        it { should have_link('Perfil', href: volunteer_path(volunteer)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end

    describe "entity" do
      let(:entity) { FactoryGirl.create(:entity) }

      describe "with valid email" do 
        before do
          fill_in "Email/Username",    with: entity.email
          fill_in "Password", with: entity.password
          click_button "Sign in"
        end

        it { should have_selector('title', text: entity.name) }
        it { should have_link('Perfil', href: entity_path(entity)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end
  end
end