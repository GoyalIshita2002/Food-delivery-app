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

    def self.create_default_charges
      DeliveryCharge.create([{min_distance: 0, max_distance:3, charge: 0},
      {min_distance: 3, max_distance:7, charge: 0},
      {min_distance: 7, max_distance:10, charge: 0}])
    end
end
