json.extract! product, :id, :name, :price, :description, :user_id, :tpye_id, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
