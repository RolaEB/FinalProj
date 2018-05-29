class AddUidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :string , :null => false, :default => '', :limit=>500
  end
end
