class RepositoryWorker
  include Sidekiq::Worker

  def perform(repo_id)
    repo = Repository.find(repo_id)
    git = Git.new(repo.git_link)
    if git.valid?
      # remove old data, could just update it
      repo.commits.delete_all
      git.stats.each do |commit|
        committer = Committer.where(email: commit[:author]).first_or_create
        commit = Commit.new sha: commit[:sha], additions: commit[:additions], deletions: commit[:deletions], files_changed: commit[:changed]
        commit.committer_id = committer.id
        commit.repository_id = repo.id
        commit.save
      end
      repo.update_column :complete, true
    end
  end
end