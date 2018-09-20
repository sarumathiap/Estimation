class AddLefttimeToSidekiqjob < ActiveRecord::Migration[5.1]
  def change
    add_column :sidekiqjobs, :lefttime, :string
  end
end
