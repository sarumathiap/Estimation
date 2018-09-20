class AddUpdateuserToSidekiqjob < ActiveRecord::Migration[5.1]
  def change
    add_column :sidekiqjobs, :updateuser, :string
  end
end
