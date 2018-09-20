class CreateSubtasks < ActiveRecord::Migration[5.1]
  def change
    create_table :subtasks do |t|
      t.string :key
      t.string :name
      t.string :assignee
      t.string :status
      t.string :issuetype
      t.string :estimated_time
      t.string :logged_time
      t.string :remaining_time
      t.references :story, foreign_key: true
      t.timestamps
    end
  end
end
