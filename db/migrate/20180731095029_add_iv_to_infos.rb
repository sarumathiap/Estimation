class AddIvToInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :infos, :iv, :string
  end
end
