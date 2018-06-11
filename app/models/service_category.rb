class ServiceCategory < ApplicationRecord
    has_many :services

    def self.options_for_select
        order('LOWER(name)').map { |e| [e.name, e.id] }
    end
end
