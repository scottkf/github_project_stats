GithubProjectStats::Application.routes.draw do
	resources :repositories, only: [:index, :show]
  root to: 'repositories#index'
end
