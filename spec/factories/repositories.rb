# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repository do
    url 'example/Hello'
    after(:build) do |repo|
    	Octokit.stub(:repo).and_return({})
      Octokit.stub(:rate_limit).and_return(true)
    end
    factory :invalid_repository do
      url 'test'
      after(:build) do |repo|
        Octokit.stub(:repo).and_return(false)
      end
    end
    factory :rate_limit do
      url 'test'
      after(:build) do |repo|
        Octokit.stub(:rate_limit).and_return(false)
      end
    end
  end
end
