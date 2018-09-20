class CreateSidekiqjobs < ActiveRecord::Migration[5.1]
  def change
    create_table :sidekiqjobs do |t|
      t.string :jobid
      t.string :start_progess
      t.string :end_progress

      t.timestamps
    end
  end
end
