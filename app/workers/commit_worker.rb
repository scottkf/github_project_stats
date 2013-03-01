class CommitWorker
  include Sidekiq::Worker

  def perform(repo_id, commits, page, total_pages)
    commits.each do |commit|
      committer = Committer.where(email: commit[:author]).first_or_create
      c = Commit.where(sha: commit[:sha]).first_or_initialize \
        committer_id: committer.id, 
        repository_id: repo_id, 
        additions: commit[:additions],
        deletions: commit[:deletions],
        files_changed: commit[:changed]
      c.save
    end
    Repository.update(repo_id, complete:true) if page == total_pages
  end
end