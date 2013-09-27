class AddTempUToUsers < ActiveRecord::Migration
  def change
    add_column :users, :temp_u, :string
  end
end
