class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :user_id
      t.integer :tpye_id
      t.integer :category_id

      t.timestamps
    end
  end
end
