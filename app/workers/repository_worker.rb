class RepositoryWorker
  include Sidekiq::Worker

  def perform(repo_id)
    repo = Repository.find(repo_id)
    git = Git.new(repo.git_link)
    if git.valid?
      per_page = 20
      total_pages = (git.commits.to_f / per_page).ceil
      1.upto(total_pages) do |page|
        CommitWorker.perform_async(repo_id, git.stats(page: page, per_page: per_page), page, total_pages)
      end
    end
  end
end