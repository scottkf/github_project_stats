class Repository < ActiveRecord::Base
	has_many :committers, :through => :commits
	has_many :commits, :dependent => :destroy

	validates :url, uniqueness: true, presence:true
	validate :valid_url?

	scope :processing, -> {where(complete: false)}
	scope :complete, -> {where(complete: true)}

	before_validation :commonize_url

	# split apart the url to get the github link
	def self.parse(url)
		return unless url
		url.match(/([^\/]*)\/([^\/]*)\/?$/).captures rescue nil
	end

	# to avoid duplicate urls, set them in a common format
	def commonize_url
		write_attribute(:url, github) if author && name
	end

	def github
		[author, name].join("/")
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

	def valid_url?
		status = Octokit.repo(github) rescue false
		errors.add(:url, I18n.t(:invalid_repo)) if !status
		status ? true : false
	end

end
