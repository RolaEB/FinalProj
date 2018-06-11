json.extract! service, :id, :name, :country, :city, :address, :service_category_id, :img, :description, :created_at, :updated_at
json.url service_url(service, format: :json)
