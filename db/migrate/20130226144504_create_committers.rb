class CreateCommitters < ActiveRecord::Migration
  def change
    create_table :committers do |t|
      t.string :email
      t.integer :additions, default: 0
      t.integer :deletions, default: 0
      t.references :repository
      
      t.timestamps
    end
  end
end
