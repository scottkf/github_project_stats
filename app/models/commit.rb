class Commit < ActiveRecord::Base
  belongs_to :committer
  belongs_to :repository

  validates_uniqueness_of :sha
  validates_presence_of :additions, :deletions, :files_changed, :sha

  scope :sum_stats, ->(column='additions') {select("committer_id, sum(#{column}) as #{column}").group("committer_id").order("#{column} desc")}
end
