class RepositoriesController < ApplicationController
	respond_to :html, :json

	def index
		@repository = Repository.new
	end

	def show
		@repository = Repository.find(params[:id])
		respond_with @repository
	end

	def create
		@repository = Repository.first_or_create(repository_params)
		# if it's not valid, show the error
		return render :index if !@repository.valid?
		# perform analytics if it hasn't been completed
		RepositoryWorker.perform_async(@repository.id) unless @repository.complete
		redirect_to @repository
	end

	private
	def repository_params
		params.require(:repository).permit(:url)
	end
end
