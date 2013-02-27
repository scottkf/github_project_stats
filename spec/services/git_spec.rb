require 'spec_helper'

describe Git do
	# cleanup repos
	after(:all) {`rm -rf #{[Rails.root, 'tmp/test/*'].join("/")}`}
	describe ".valid?" do
		it 'is true if repo exists' do
			git = Git.new([Rails.root, 'spec/support/ability-js/.git'].join("/"))
			git.valid?.should be true
		end
		it 'is not otherwise' do
			git = Git.new('')
			git.valid?.should be false
		end
	end
	describe ".stats" do
		let(:git){Git.new([Rails.root, 'spec/support/ability-js/.git'].join("/"))}		
		context "when a valid repo" do
			# stats are calculated manually
			it "has the correct number of commits" do
				git.stats.size.should == 19
			end
			it "shows the correct number of additions" do
				git.stats.inject(0) {|sum, commit| sum+= commit[:additions] if commit[:author] == "scott@tesoriere.com"; sum}.should == 208
			end
			it "shows the correct number of deletions" do
				git.stats.inject(0) {|sum, commit| sum+= commit[:deletions] if commit[:author] == "scott@tesoriere.com"; sum}.should == 161
			end
			it "shows the correct number of files changed" do
				git.stats.inject(0) {|sum, commit| sum+= commit[:changed] if commit[:author] == "scott@tesoriere.com"; sum}.should == 24
			end
			it "shows the correct author" do
				git.stats.second[:author].should == "gautamsarora3@gmail.com"
			end
			it "shows the correct sha hash" do
				git.stats.first[:sha].should == "5dc2e28973ebf28d1628cf4b8ff245206f8e6934"
			end
		end
		context "when invalid" do
			it "throws an error" do
				git.stub(:valid?).and_return false
				expect {git.stats}.to raise_error
			end
		end
	end
end