class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.string :photo
      t.integer :price
      t.string :phone
      t.integer :age
      t.integer :user_id

      t.timestamps
    end
  end
end
