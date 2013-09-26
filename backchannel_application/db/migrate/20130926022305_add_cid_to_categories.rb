class AddCidToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :cid, :integer
  end
end
