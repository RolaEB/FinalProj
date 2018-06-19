class ServiceCategory < ApplicationRecord
    has_many :services

    validates:name,presence: true 

    def self.options_for_select
        order('LOWER(name)').map { |e| [e.name, e.id] }
    end
end
