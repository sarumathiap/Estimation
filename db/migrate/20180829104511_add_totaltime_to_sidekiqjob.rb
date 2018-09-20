class AddTotaltimeToSidekiqjob < ActiveRecord::Migration[5.1]
  def change
    add_column :sidekiqjobs, :totaltime, :string
  end
end
