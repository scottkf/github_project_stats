class RepositoriesController < ApplicationController
	respond_to :html, :json

	def index
		@repositories = Repository.limit(20)
	end

	def show
		@repository = Repository.find(params[:id])
		respond_with @repository
	end
end
