class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items

  enum :status, { open: 0, ordered: 1 }
end
