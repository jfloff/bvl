#encoding: utf-8

require 'spec_helper'

describe "Entity pages" do

  subject { page }

  describe "profile page" do
    let(:entity) { FactoryGirl.create(:entity) }
    before { visit entity_path(entity) }

    it { should have_selector('h1',    text: entity.name) }
    it { should have_selector('title', text: "#{entity.name} (#{entity.username})") }
  end

  describe "signup page" do
    before { visit new_entity_path }

    it { should have_selector('h1',    text: 'Registo de Entidades') }
    it { should have_selector('title', text: full_title('Registo de Entidades')) }
  end

  describe "signup" do

    before { visit new_entity_path }

    let(:submit) { "Criar conta" }

    describe "with invalid information" do
      
      it "should not create an entity" do
        expect { click_button submit }.not_to change(Entity, :count)
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

      it "should create an entity" do
        expect { click_button submit }.to change(Entity, :count).by(1)
      end

      describe "after saving the entity" do
        before { click_button submit }
        let(:entity) { Entity.find_by_email('user@example.com') }

        it { should have_selector('title', text: entity.name) }
        it { should have_selector('div.alert.alert-success', text: 'Bem-vindo') }
      end
    end
  end
end
