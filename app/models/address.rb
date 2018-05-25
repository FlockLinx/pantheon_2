class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, inverse_of: :address
  belongs_to :state
end
