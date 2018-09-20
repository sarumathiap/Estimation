class CreateAuthusers < ActiveRecord::Migration[5.1]
  def change
    create_table :authusers do |t|
      t.string :email
      t.string :status
      t.string :role

      t.timestamps
    end
  end
end
