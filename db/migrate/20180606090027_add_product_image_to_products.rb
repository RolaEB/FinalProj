class AddProductImageToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :productImage, :string
  end
end
