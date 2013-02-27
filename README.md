README
======

#### Starting

bundle install
gem install foreman
foreman start

**Notes**:

* Requires redis for sidekiq to process git repos
* Will not work on heroku because it clones repos
* Does not use the github api because of rate limiting

#### Todo

Add a flag or check redis to see if the thing is currently being processed
Remove old repos
Add a progress indicator which can be received through the git class
Add a notification if you hit the ratelimit