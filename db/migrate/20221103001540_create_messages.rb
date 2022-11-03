class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :from_user, null: false
      t.references :to_user, null: false
      t.text :message
      t.datetime :date

      t.timestamps
    end
    add_foreign_key :messages, :users, column: :from_user_id
    add_foreign_key :messages, :users, column: :to_user_id
  end
end
