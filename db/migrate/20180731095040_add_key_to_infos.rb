class AddKeyToInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :infos, :key, :string
  end
end
