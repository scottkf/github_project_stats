class Git
  def initialize(repo)
    clone(repo)
  end

  def clone(repo)
    tmp  = Rails.root.to_s+"/tmp/#{Rails.env}/#{Repository.github(repo)}"
    grit = Grit::Git.new(tmp)
    grit.clone({quiet: false, verbose: true, progress: true, branch: 'master', timeout: false}, repo, tmp)
    @repo = Grit::Git.new(tmp+"/.git")
  end

  # checks if the repo exists
  def valid?
    !@repo.show.blank?
  end

  def commits
    raise I18n.t(:invalid_repo) if !@repo || !valid?
    @commits ||= @repo.send("rev-list", {count:true}, 'HEAD').chomp.to_i
  end

  def stats(*args)
    raise I18n.t(:invalid_repo) if !@repo || !valid?
    options = args.extract_options!

    if options[:page]
      options[:n] = options[:per_page] || 20
      options[:skip] = options[:n]*(options[:page]-1)
      options.delete(:page)
      options.delete(:per_page)
    end
    options.merge!({shortstat:true, z:true, timeout: false})

    @repo.log(options,"master").split("\0").map do |commit|
      commit.match(/commit (.*)\n/)
      sha = $1
      commit.match(/<(.*)>/)
      author = $1
      commit.match /(\d+) files? changed/
      changed = $1
      commit.match /(\d+) insertions?/
      additions = $1
      commit.match /(\d+) deletions?/
      deletions = $1
      {sha: sha, author: author, changed: changed.to_i, additions:additions.to_i, deletions: deletions.to_i}
    end
  end
end