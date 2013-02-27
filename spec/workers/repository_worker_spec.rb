require 'spec_helper'

describe RepositoryWorker do
	let(:repository){FactoryGirl.create(:repository)}
	before(:each) do 
		Repository.any_instance.stub(:git_link).and_return([Rails.root, 'spec/support/ability-js/.git'].join("/"))
		RepositoryWorker.perform_async(repository.id)
		RepositoryWorker.drain
	end
	describe 'processing' do
		it 'removes old commits' do
			RepositoryWorker.perform_async(repository.id)
			expect { RepositoryWorker.drain }.to_not change{repository.commits.size}
		end
		it 'creates the commits' do
			repository.commits.count.should == 19
		end
		it 'updates the repo as complete' do
			repository.reload.complete.should == true
		end
	end
	describe 'commits' do
		subject(:commit) {repository.commits.order('id asc').to_a[1]}
		its(:committer) {commit.committer.email.should == "gautamsarora3@gmail.com"}
		its(:sha) { should == "6e8b09c77f6af447c2df91747dd985e27f764770" }
		its(:additions) {should == 1}
		its(:deletions) {should == 1}
		its(:files_changed) {should == 1}
	end
end