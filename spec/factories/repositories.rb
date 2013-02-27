# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repository do
    url 'example/Hello'
    after(:build) do |repo|
    	repo.stub(:valid_url?).and_return true
    end
  end
end
