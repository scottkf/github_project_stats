class CreateCommitters < ActiveRecord::Migration
  def change
    create_table :committers do |t|
      t.string :email
      
      t.timestamps
    end
  end
end
