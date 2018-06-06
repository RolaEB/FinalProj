class AddTypeIdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :type_id, :string
  end
end
