require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Banco de Voluntariado de Lisboa') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'Ajuda') }
    it { should have_selector('title', text: full_title('Ajuda')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'Sobre') }
    it { should have_selector('title', text: full_title('Sobre')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contactos') }
    it { should have_selector('title', text: full_title('Contactos')) }
  end
end
