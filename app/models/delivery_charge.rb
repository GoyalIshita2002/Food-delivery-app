class DeliveryCharge < ApplicationRecord
    validates :min_distance, presence: true
    validates :max_distance, presence: true
    validates :charge, presence: true

    private
  
    def self.upsert(min_distance, max_distance, charge)
      existing_charge = find_by(min_distance: min_distance, max_distance: max_distance)
      if existing_charge
        existing_charge.update(charge: charge)
      else
        create(min_distance: min_distance, max_distance: max_distance, charge: charge)
      end
    end
end
