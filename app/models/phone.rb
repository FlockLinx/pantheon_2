class Phone < ApplicationRecord
    belongs_to :phoneable, polymorphic: true, inverse_of: :phone
end
