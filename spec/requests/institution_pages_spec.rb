#encoding: utf-8

require 'spec_helper'

describe "Institution pages" do

  subject { page }

  describe "signup page" do
    before { visit institution_signup_path }

    it { should have_selector('h1',    text: 'Registo de Instituições') }
    it { should have_selector('title', text: full_title('Registo de Instituições')) }
  end
end
