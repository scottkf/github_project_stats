source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.beta1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'
  gem 'slim-rails'
	gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
	gem 'less-rails-bootstrap'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'puma', '>= 2.0.0.b4'
gem 'sidekiq'
gem 'dalli'
gem 'simple_form', '~> 3.0.x'

# github api ease
gem 'octokit'
# inplace git management
gem 'grit'

gem 'pg'

group :development, :test do
	gem "shoulda-matchers"
	gem 'therubyracer' 
	gem 'libv8', '~> 3.11.8'
	gem 'factory_girl_rails'
	gem 'capybara', '~> 2.0.x'
	gem 'database_cleaner'
	gem "rspec-rails"
end