class Repository < ActiveRecord::Base
	has_many :committers, :through => :commits
	has_many :commits, :dependent => :destroy

	validate :validate_repo
	validates :url, uniqueness: true, presence:true

	scope :processing, -> {where(complete: false)}
	scope :complete, -> {where(complete: true)}

	# split apart the url to get the github link
	def self.parse(url)
		return unless url
		url.match(/([^\/]*)\/([^\/]*)\/?$/).captures rescue nil
	end

	def self.github(url)
		author, name = self.parse(url)
		return url unless author && name
		[author, name].join("/")
	end

	def url=(u)
		write_attribute(:url, u)
		write_attribute(:url, github) if author && name			
	end

	def github
		self.class.github(url)
	end

	def html_link
		"http://github.com/#{github}"
	end

	def git_link
		"git://github.com/#{github}.git"
	end

	def name
		author, repo = self.class.parse(url)
		repo
	end

	def author
		a, repo = self.class.parse(url)
		a
	end

	def validate_repo
		limit = Octokit.rate_limit rescue false
		if !limit
			errors.add(:url, I18n.t(:ratelimit_exhausted))
		else
			status = Octokit.repo(github) rescue false
			errors.add(:url, I18n.t(:invalid_repo)) unless status
		end
	end

end
