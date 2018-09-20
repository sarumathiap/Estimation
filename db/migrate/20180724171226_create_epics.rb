class CreateEpics < ActiveRecord::Migration[5.1]
  def change
    create_table :epics do |t|
      t.references :modul, foreign_key: true
      t.string :key
      t.string :name
      t.string :total_story_spent_time
      t.string :total_story_estimation_time
      t.string :total_story_remaining_time
      t.string :status
      t.timestamps
    end
  end
end
