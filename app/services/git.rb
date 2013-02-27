class Git
  def initialize(repo)
    clone(repo)
  end

  def clone(repo)
    tmp  = Rails.root.to_s+"/tmp/#{Rails.env}/#{rand(Time.now.to_i).to_s}"
    grit = Grit::Git.new(tmp)
    grit.clone({quiet: false, verbose: true, progress: true, branch: 'master', timeout: false}, repo, tmp)
    @repo = Grit::Git.new(tmp+"/.git")
  end

  # checks if the repo exists
  def valid?
    !@repo.show.blank?
  end

  def stats
    raise I18n.t(:invalid_repo) if !@repo || !valid?
    @repo.log({shortstat:true, z:true, timeout: false},"master").split("\0").map do |commit|
      commit.match(/commit (.*)\n/)
      sha = $1
      commit.match(/<(.*)>/)
      author = $1
      changed, additions, deletions = commit.match(/(\d+) files? changed, (\d+) insertions?\(\+\), (\d+) deletions?\(\-\)/).captures rescue nil
      {sha: sha, author: author, changed: changed.to_i, additions:additions.to_i, deletions: deletions.to_i}
    end
  end
end