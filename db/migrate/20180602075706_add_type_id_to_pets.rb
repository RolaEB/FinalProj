class AddTypeIdToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :type_id, :integer
  end
end
