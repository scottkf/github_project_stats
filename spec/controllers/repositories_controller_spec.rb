require 'spec_helper'

describe RepositoriesController do
	describe 'POST create' do
		context "when repo is invalid" do
			it 'will not create' do
				Octokit.stub(:repo).and_return false
				Octokit.stub(:rate_limit).and_return(true)
				expect{post :create, repository: {url: 'test'}}.to_not change{Repository.count}.from(0).to(1)
			end
		end
		context "when repo exists" do
			let(:repo) {FactoryGirl.create(:repository)}
			it 'uses an existing entry' do
				expect{post :create, repository: {url: repo.url}}.to_not change{Repository.count}.from(1).to(1)
			end
			it 'matches urls' do
				post :create, repository: {url: "git://github.com/#{repo.url}"}
				response.should redirect_to(repo)
			end
		end
		context "when repo is valid but unprocessed" do
			it 'runs in the background' do
				Octokit.stub(:repo).and_return({})
				Octokit.stub(:rate_limit).and_return(true)
				expect {
					post :create, repository: {url: 'valid/url'}
				}.to change(RepositoryWorker.jobs, :size).by(1)
			end
		end
	end
end
