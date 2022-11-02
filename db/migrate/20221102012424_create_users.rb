class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Username
      t.string :password_digest
      t.string :Email
      t.text :About

      t.timestamps
    end
  end
end