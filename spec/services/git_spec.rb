require 'spec_helper'

describe Git do
	describe ".clone" do
	end
	describe ".stats" do
		context "when a valid repo" do
			it "shows the correct number of additions"
			it "shows the correct number of deletions"
			it "shows the correct number of files changed"
			it "shows the correct author"
			it "shows the correct sha hash"
		end
		context "when invalid" do
			it "throws an error"
		end
	end
end