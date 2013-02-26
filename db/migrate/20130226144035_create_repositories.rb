class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :url
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
