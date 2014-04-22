# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission_file do
    filename "MyString"
    content_type ""
    file_contents ""
    submission nil
  end
end
