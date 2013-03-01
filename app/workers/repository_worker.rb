class RepositoryWorker
  include Sidekiq::Worker

  def perform(repo_id)
    repo = Repository.find(repo_id)
    git = Git.new(repo.git_link)
    if git.valid?
      git.stats.each do |commit|
        committer = Committer.where(email: commit[:author]).first_or_create
        c = Commit.where(sha: commit[:sha]).first_or_initialize \
          committer_id: committer.id, 
          repository_id: repo.id, 
          additions: commit[:additions],
          deletions: commit[:deletions],
          files_changed: commit[:changed]
        c.save
      end
      repo.update_column :complete, true
    end
  end
end