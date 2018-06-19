class Product < ApplicationRecord
    belongs_to :category
    belongs_to :type
    has_many :reviews
    belongs_to :user

    validates:name,presence: true 
    validates:price,presence: true 
    validates:user_id,presence: true 
    validates:category_id,presence: true 
    validates:type_id,presence: true 
    validates:brand,presence: true 
    validates:productImage,presence: true 

    mount_uploader :productImage, ImageUploader

    #for search and filter
    filterrific(
   default_filter_params: { sorted_by: 'created_at_desc' },
   available_filters: [
     :sorted_by,
     :search_query,
     :with_type_id,
     :with_category_id
   ]
 )
   #scopes
   scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 3
    where(
      terms.map {
        or_clauses = [
          "LOWER(products.name) LIKE ?",
          "LOWER(products.description) LIKE ?",
          "LOWER(products.brand) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )

}

scope :sorted_by, lambda { |sort_option|
# extract the sort direction from the param value.
direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
case sort_option.to_s
when /^created_at_/
  order("products.created_at #{ direction }")
when /^price_/
  order("LOWER(products.price) #{ direction }")

else
  raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
end
}

scope :with_type_id, lambda { |type_ids|
where(:type_id => [*type_ids])
}

scope :with_category_id, lambda { |category_ids|
where(:category_id => [*category_ids])
}

def self.options_for_sorted_by
    [
      
      ['Date created (newest first)', 'created_at_desc'],
      ['Date created (oldest first)', 'created_at_asc'],
      ['Price(high to low)', 'price_asc'],
      ['Price (low to high)', 'price_desc'],
      
    ]
end 


  
end
