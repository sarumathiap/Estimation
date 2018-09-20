class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.references :epic, foreign_key: true
      t.string :key
      t.string :name
      t.string :QE_assignee
      t.string :status
      t.string :sub_task_story_estimated_time
      t.string :sub_task_story_logged_time
      t.string :sub_task_story_remaining_time
      t.timestamps
    end
  end
end
