class AddLongitudeToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :longitude, :float
  end
end
