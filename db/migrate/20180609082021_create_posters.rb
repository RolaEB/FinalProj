class CreatePosters < ActiveRecord::Migration[5.1]
  def change
    create_table :posters do |t|
      t.string :name
      t.string :breed
      t.string :img
      t.text :description
      t.string :phone
      t.string :last_seen
      t.integer :user_id

      t.timestamps
    end
  end
end
