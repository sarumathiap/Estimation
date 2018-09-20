class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :role
      t.string :status

      t.timestamps
    end
  end
end
