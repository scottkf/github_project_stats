class RepositoriesController < ApplicationController

	def index
		@repositories = Repository.limit(20)
	end
end
