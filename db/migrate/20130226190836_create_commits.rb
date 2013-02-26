class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.references :committer,     index: true
      t.references :repository,    index: true
      t.integer 	 :additions,     default: 0
      t.integer    :files_changed, default: 0
      t.integer 	 :deletions, 	   default: 0
      t.string 	 	 :sha


      t.timestamps
    end
  end
end
