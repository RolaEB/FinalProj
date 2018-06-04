class Pet < ApplicationRecord
    belongs_to :user
    belongs_to :type
   
    #vlidations
    validates:name,presence: { message: "give your pet a name please" } ,length:{minimum:4}
         validates :price, presence: true,numericality: { greater_than_or_equal_to: 0 }
         validates :photo,presence: true
         validates :breed,presence: true
         validates :phone,presence: true
         validates :age,presence: true
         validates :type_id,presence: true
         validates :user_id,presence: true
         
    #for pet photo
    mount_uploader :photo, PhotoUploader
    #for search and filtering
    filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
    :available_filters => %w[
      sorted_by
      search_query
      with_type_id
      
    ]
    # default for will_paginate
    self.per_page = 9

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
          "LOWER(pets.name) LIKE ?",
          "LOWER(pets.breed) LIKE ?",
          "LOWER(pets.description) LIKE ?",
          

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
      order("pets.created_at #{ direction }")
    when /^price_/
      order("pets.price #{ direction }")
    
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
    }

    scope :with_type_id, lambda { |type_ids|
    where(:type_id => [*type_ids])
    }

    delegate :name, :to => :type, :prefix => true

    def self.options_for_sorted_by
        [
          ['Creation date (newest first)', 'created_at_desc'],
          ['Creation date (oldest first)', 'created_at_asc'],
          ['Price (highest first)', 'price_desc'],
          ['Price (lowest first)', 'price_asc'],
          
          
        ]
    end
    
    
    def decorated_created_at
        created_at.to_date.to_s(:long)
    end
   
end
