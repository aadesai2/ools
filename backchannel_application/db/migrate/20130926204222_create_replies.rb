class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :post_id
      t.integer :id
      t.string :description
      t.integer :num_likes
      t.string :temp_r

      t.timestamps
    end
  end
end
