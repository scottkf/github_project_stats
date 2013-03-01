require 'spec_helper'

describe RepositoryWorker do
	let(:repository){FactoryGirl.create(:repository)}
	let(:work){RepositoryWorker.new}
	before(:each) do 
		Repository.any_instance.stub(:git_link).and_return([Rails.root, 'spec/support/dot_git'].join("/"))
	end
	describe 'processing' do
		it 'processes commits in the worker' do
			expect { work.perform(repository.id) }.to change{CommitWorker.jobs.size}.from(0).to(1)
		end
	end
end