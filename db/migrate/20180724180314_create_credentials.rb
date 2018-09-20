class CreateCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :credentials do |t|
      t.text :encry_username
      t.text :encry_password
      t.text :iv
      t.text :password_digest
      t.timestamps
    end
  end
end
