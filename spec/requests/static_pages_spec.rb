#encoding: utf-8

require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Banco de Voluntariado de Lisboa' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Ajuda' }
    let(:page_title) { 'Ajuda' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'Sobre' }
    let(:page_title) { 'Sobre' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Contactos' }
    let(:page_title) { 'Contactos' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Sobre"
    page.should have_selector 'title', text: full_title('Sobre')
    click_link "Ajuda"
    page.should have_selector 'title', text: full_title('Ajuda')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contactos')
    click_link "Home"
    click_link "Registo de Entidades"
    page.should have_selector 'title', text: full_title('Registo de Entidades')
    click_link "bvl"
    click_link "Registo de Voluntários"
    page.should have_selector 'title', text: full_title('Registo de Voluntários')
    visit root_path
  end
end
