require 'spec_helper'

describe Repository do
	let(:repo) {FactoryGirl.build(:repository)}

	it {should validate_presence_of(:url)}
	it {should validate_presence_of(:complete)}

	it '.github sets up a github repo link' do
		repo.github.should == "#{repo.author}/#{repo.name}"
	end
	it '.link finishes a githup repo link' do
		repo.github_link.should == "git://github.com/#{repo.github}.git"
	end
	it '.url= resets the repo name and author' do
		repo.url= nil
		repo.name.should == nil
		repo.author.should == nil
	end

	describe ".valid_repo?" do
		it 'is not false when the repo is valid' do
			Octokit.stub(:repo).and_return({})
			repo.valid?.should_not == false
		end
		it 'is false otherwise'  do
			Octokit.stub(:repo).and_return(false)
			repo.valid?.should == false
		end
	end

	describe "#parse" do
		context "when the repo is valid" do
			it "accepts trailing slashes" do
				Repository.parse("scottkf/ability-js/").should == ["scottkf", "ability-js"]
			end
			it "formats with just the author and repo" do
				Repository.parse("scottkf/ability-js/").should == ["scottkf", "ability-js"]
			end
			it "accepts a url" do
				Repository.parse("git://github.com/scottkf/ability-js/").should == ["scottkf", "ability-js"]
			end
		end
	end

end
