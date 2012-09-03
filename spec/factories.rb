FactoryGirl.define do
  factory :volunteer do
  	username "mhartl"
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end