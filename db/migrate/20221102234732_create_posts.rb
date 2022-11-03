class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :groupid
      t.text :message
      t.datetime :date

      t.timestamps
    end
  end
end
