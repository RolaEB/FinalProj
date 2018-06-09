class Poster < ApplicationRecord
    belongs_to :user

    mount_uploader :img, ImageUploader

    #for search and filtering
    filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
    :available_filters => %w[
      sorted_by
      search_query
      
      
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
          "LOWER(posters.name) LIKE ?",
          "LOWER(posters.breed) LIKE ?",
          "LOWER(posters.description) LIKE ?",
          

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
      order("posters.created_at #{ direction }")
    
    
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
    }

    def self.options_for_sorted_by
        [
          ['Creation date (newest first)', 'created_at_desc'],
          ['Creation date (oldest first)', 'created_at_asc'],
          
          
          
        ]
    end
    



end
