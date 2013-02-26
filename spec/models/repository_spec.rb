require 'spec_helper'

describe Repository do
	it {should validate_presence_of(:url)}
	it {should validate_presence_of(:complete)}

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
