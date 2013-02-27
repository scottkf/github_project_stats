require 'spec_helper'

describe RepositoriesController do
	describe 'POST create' do
		context "when repo is invalid" do
			it 'renders'
		end
		context "when repo exists" do
			it 'uses an existing entry'
		end
		context "when repo is valid but unprocessed" do
			it 'runs in the background'
		end
	end
end
