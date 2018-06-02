class Type < ApplicationRecord
    has_many :pets ,:dependent => :nullify

    public
    def self.options_for_select
        order('LOWER(name)').map { |e| [e.name, e.id] }
      end
end
