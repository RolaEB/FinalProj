class AddProviderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string, :null => false, :default => '', :limit=>50
  end
end
