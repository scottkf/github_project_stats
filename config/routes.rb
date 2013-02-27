GithubProjectStats::Application.routes.draw do
	resources :repositories, only: [:index, :show, :create]
  root to: 'repositories#index'
end
