require 'spec_helper'

describe Commit do
	it {should validate_presence_of(:additions)}
	it {should validate_presence_of(:deletions)}
	it {should validate_presence_of(:files_changed)}
	it {should validate_presence_of(:sha)}	
	it {should validate_uniqueness_of(:sha)}
end
