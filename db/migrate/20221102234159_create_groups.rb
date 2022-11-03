class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :groupname
      t.string :pic_url

      t.timestamps
    end
  end
end
