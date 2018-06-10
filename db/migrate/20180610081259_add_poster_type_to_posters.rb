class AddPosterTypeToPosters < ActiveRecord::Migration[5.1]
  def change
    add_column :posters, :poster_type, :string
  end
end
