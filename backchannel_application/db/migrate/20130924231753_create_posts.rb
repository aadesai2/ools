class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :id
      t.string :title
      t.text :description
      t.integer :category_id
      t.integer :num_likes
      t.string :temp_p

      t.timestamps
    end
  end
end
