class CreateHardcodes < ActiveRecord::Migration[5.1]
  def change
    create_table :hardcodes do |t|
      t.string :name
      t.text :hardcodedata
      t.timestamps
    end
  end
end
