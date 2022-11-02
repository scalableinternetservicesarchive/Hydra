class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :Username
      t.string :Message
      t.string :string
      t.integer :Likes

      t.timestamps
    end
  end
end
