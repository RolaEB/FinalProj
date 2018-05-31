json.extract! pet, :id, :name, :breed, :photo, :price, :phone, :age, :user_id, :created_at, :updated_at
json.url pet_url(pet, format: :json)
