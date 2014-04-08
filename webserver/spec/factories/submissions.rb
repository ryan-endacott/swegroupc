# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    receipt "MyText"
    user nil
    ip_address "MyText"
    filename "MyText"
    content_type "MyText"
    file_contents ""
  end
end
