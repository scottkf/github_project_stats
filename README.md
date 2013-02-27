README
======

#### Starting

* bundle install
* gem install foreman
* foreman start

**Notes**:

* Requires redis for sidekiq to process git repos
* Will not work on heroku because it clones repos
* Does not use the github api for commits because of rate limiting, uses the git repo directly

#### Todo

* Remove old repos
* Add a progress indicator which can be received through the git class