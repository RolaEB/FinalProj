class Question < ApplicationRecord
    belongs_to :user
    has_many :answers

    #for search and filter
    filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
     :search_query,
     :sorted_by,
     
     
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
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(questions.content) LIKE ?",
          "LOWER(questions.title) LIKE ?",
          

          
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
      order("questions.created_at #{ direction }")
    
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
}

def self.options_for_sorted_by
    [
      
      ['Date created (newest first)', 'created_at_desc'],
      ['Date created (oldest first)', 'created_at_asc'],
     
    ]
end

def decorated_created_at
    created_at.to_date.to_s(:long)
end




end
