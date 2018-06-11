class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name
      t.string :country
      t.string :city
      t.string :address
      t.integer :service_category_id
      t.string :img
      t.text :description

      t.timestamps
    end
  end
end
