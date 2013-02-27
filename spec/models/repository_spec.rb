require 'spec_helper'

describe Repository do
	let(:repo) {FactoryGirl.build(:repository)}

	it {should validate_presence_of(:url)}

	it '.github sets up a github repo link' do
		repo.github.should == "#{repo.author}/#{repo.name}"
	end
	it '.git_link finishes a githup repo link' do
		repo.git_link.should == "git://github.com/#{repo.github}.git"
	end
	it '.html_link finishes a githup repo link' do
		repo.html_link.should == "http://github.com/#{repo.github}"
	end
	it '.url= sets a common url' do
		repo.url = "http://github.com/scottkf/ability-js"
		repo.url.should == "scottkf/ability-js"
	end

	it 'is valid only if repo exists' do
		repo = FactoryGirl.build(:invalid_repository)
		repo.should_not be_valid
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
