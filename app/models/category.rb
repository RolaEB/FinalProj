class Category < ApplicationRecord
    has_many :products
    public
    def self.options_for_select
        order('LOWER(name)').map { |e| [e.name, e.id] }
    end
end
