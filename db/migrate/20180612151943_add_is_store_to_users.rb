class AddIsStoreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_store, :integer
  end
end
