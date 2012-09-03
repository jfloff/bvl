#encoding: utf-8

require 'spec_helper'

describe "Entities pages" do

  subject { page }

  describe "signup page" do
    before { visit entity_signup_path }

    it { should have_selector('h1',    text: 'Registo de Entidades') }
    it { should have_selector('title', text: full_title('Registo de Entidades')) }
  end
end
