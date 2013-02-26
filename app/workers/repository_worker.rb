class RepositoryWorker
  include Sidekiq::Worker

  def perform(url)
    puts 'Doing hard work'
  end
end