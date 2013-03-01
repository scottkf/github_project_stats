require 'spec_helper'

describe Git do
	let(:git){Git.new([Rails.root, 'spec/support/dot_git'].join("/"))}		
	# cleanup repos
	after(:all) {`rm -rf #{[Rails.root, 'tmp/test/*'].join("/")}`}
	describe ".valid?" do
		it 'is true if repo exists' do
			git = Git.new([Rails.root, 'spec/support/dot_git'].join("/"))
			git.valid?.should be true
		end
		it 'is not otherwise' do
			git = Git.new('')
			git.valid?.should be false
		end
	end
	describe '.commits' do
		it 'should correctly show the number of commits' do
			git.commits.should == 19
		end
	end
	describe ".stats" do
		context "when using pagination" do
			it 'can choose the page' do
				git.stats(page:1, per_page:10)[0][:sha].should == "5dc2e28973ebf28d1628cf4b8ff245206f8e6934"
				git.stats(page:2, per_page:10)[0][:sha].should == "a4f31743d3beb71141c16125089cede5c14d65cf"
			end
			it 'can per_page' do
				git.stats(page:1, per_page:5).size.should == 5
			end
		end
		context "when a valid repo" do
			# stats are calculated manually
			it "has the correct number of commits" do
				git.stats.size.should == 19
			end
			it "shows the correct number of additions" do
				git.stats.inject(0) {|sum, commit| sum+= commit[:additions] if commit[:author] == "scott@tesoriere.com"; sum}.should == 419
			end
			it "shows the correct number of deletions" do
				git.stats.inject(0) {|sum, commit| sum+= commit[:deletions] if commit[:author] == "scott@tesoriere.com"; sum}.should == 161
			end
			it "shows the correct number of files changed" do
				git.stats.inject(0) {|sum, commit| sum+= commit[:changed] if commit[:author] == "scott@tesoriere.com"; sum}.should == 31
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