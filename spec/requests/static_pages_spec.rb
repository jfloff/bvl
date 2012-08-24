# encoding: UTF-8

require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Bolsa de Voluntários de Lisboa" }

  describe "Home page" do

    it "should have the content 'Home'" do
      visit '/static_pages/home'
      page.should have_content('Home')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "#{base_title} | Home")
    end
  end

  describe "Help page" do

    it "should have the content 'Ajuda'" do
      visit '/static_pages/help'
      page.should have_content('Ajuda')
    end

    it "should have the title 'Ajuda'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "#{base_title} | Ajuda")
    end
  end

  describe "About page" do

    it "should have the content 'Sobre'" do
      visit '/static_pages/about'
      page.should have_content('Sobre')
    end

    it "should have the title 'Sobre'" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "#{base_title} | Sobre")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contactos'" do
      visit '/static_pages/contact'
      page.should have_content('Contactos')
    end

    it "should have the title 'Contactos'" do
      visit '/static_pages/contact'
      page.should have_selector('title', :text => "#{base_title} | Contactos")
    end
  end
end
