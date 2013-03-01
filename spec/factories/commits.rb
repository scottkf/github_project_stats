# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
  	committer
  	repository
    sha {"6b71a9974897#{rand(1000)}#{rand(1000)}"}
    additions {rand(10)}
    deletions {rand(5)}
    files_changed {rand(4)}
  end
end
