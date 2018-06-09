json.extract! poster, :id, :name, :breed, :img, :description, :phone, :last_seen, :user_id, :created_at, :updated_at
json.url poster_url(poster, format: :json)
