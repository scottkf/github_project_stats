class Repository < ActiveRecord::Base
	has_many :committers, :through => :commits
	has_many :commits, :dependent => :destroy

	validates_presence_of :complete, :url
	attr_accessor :name, :author

	def self.parse(url)
		url.match(/([^\/]*)\/([^\/]*)\/?$/).captures
	end

	def github
		[name, author].join("/")
	end

	def name
		author, name = self.class.parse(url)
		self.name ||= name
	end

	def author
		author, repo = self.class.parse(url)
		self.author ||= author
	end

	def valid_repo?
		Octokit.repo(github) rescue false
	end

end
