class Service < ApplicationRecord
    belongs_to :user
    belongs_to :service_category

    mount_uploader :img, ImageUploader


    validates:name,presence: true 
    validates:city,presence: true 
    validates:address,presence: true 
    validates:service_category_id,presence: true 
    validates:img,presence: true 
    validates:user_id,presence: true 
    validates:phone,presence: true 


    #for google map
    geocoded_by :address
    after_validation :geocode

    #for search and filter
    filterrific(
   default_filter_params: { sorted_by: 'created_at_desc' },
   available_filters: [
     :sorted_by,
     :search_query,
     :with_service_category_id
    
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
          "LOWER(services.name) LIKE ?",
          "LOWER(services.city) LIKE ?",
          "LOWER(services.address) LIKE ?",
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
  order("services.created_at #{ direction }")

else
  raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
end
}

scope :with_service_category_id, lambda { |service_category_ids|
    where(:service_category_id => [*service_category_ids])
}

def self.options_for_sorted_by
    [
      
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      
    ]
end



end
