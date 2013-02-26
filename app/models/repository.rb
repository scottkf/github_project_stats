class Repository < ActiveRecord::Base
	has_many :committers, :through => :commits
	has_many :commits, :dependent => :destroy

	validates_presence_of :complete, :url
	attr_accessor :name, :author


	# split apart the url to get the github link
	def self.parse(url)
		return unless url
		url.match(/([^\/]*)\/([^\/]*)\/?$/).captures
	end



	# avoid stale data
	def url=(u)
		name = author = nil
		write_attribute(:url, u)
	end

	def github
		[author, name].join("/")
	end

	def github_link
		"git://github.com/#{github}.git"
	end

	def name
		author, repo = self.class.parse(url)
		name ||= repo
	end

	def author
		a, repo = self.class.parse(url)
		author ||= a
	end

	def valid?
		Octokit.repo(github) rescue false
	end

end
