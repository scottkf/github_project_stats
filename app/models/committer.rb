class Committer < ActiveRecord::Base
	validates :email, presence: true, uniqueness: true

	has_many :commits, :dependent => :destroy
	has_many :repositories, :through => :commits
end
