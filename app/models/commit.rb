class Commit < ActiveRecord::Base
  belongs_to :committer
  belongs_to :repository

  validates_presence_of :additions, :deletions, :files_changed, :sha
end
