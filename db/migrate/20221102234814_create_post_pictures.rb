class CreatePostPictures < ActiveRecord::Migration[7.0]
  def change
    create_table :post_pictures do |t|
      t.references :post, null: false, foreign_key: true
      t.string :pic_url

      t.timestamps
    end
  end
end
