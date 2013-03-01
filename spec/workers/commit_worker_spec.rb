require 'spec_helper'

describe CommitWorker do
	let(:repository){FactoryGirl.create(:repository)}
	let(:work){CommitWorker.new}
	let(:git) {Git.new([Rails.root, 'spec/support/dot_git'].join("/"))}
	before(:each) do 
		Repository.any_instance.stub(:git_link).and_return([Rails.root, 'spec/support/dot_git'].join("/"))
		work.perform(repository.id, git.stats(page: 1, per_page: 10), 1, 2)
	end
	describe 'processing' do
		it 'creates the commits' do
			repository.commits.count.should == 10
		end
		it 'can sum the additions' do
			committer = Committer.where(email: 'scott@tesoriere.com').first
			expected = git.stats(page:1, per_page:10).inject(0) {|sum,x| sum+=x[:additions] if x[:author] == committer.email; sum}
			repository.commits.sum_stats(:additions).where(committer_id: committer.id).first.additions.should == expected
		end
		it 'updates the repo as complete' do
			work.perform(repository.id, git.stats(page: 2, per_page: 10), 2, 2)
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