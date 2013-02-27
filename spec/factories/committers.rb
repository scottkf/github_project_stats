# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :committer do
    email "test#{n}@test.com"
  end
end
