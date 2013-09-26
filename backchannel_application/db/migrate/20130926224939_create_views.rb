class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :post_id
      t.string :user_id
      t.integer :reply_id
      t.integer :like

      t.timestamps
    end
  end
end
