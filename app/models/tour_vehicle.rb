# == Schema Information
#
# Table name: tour_vehicles
#
#  id         :integer          not null, primary key
#  vehicle_id :integer
#  tour_id    :integer
#
# Indexes
#
#  index_tour_vehicles_on_tour_id                 (tour_id)
#  index_tour_vehicles_on_tour_id_and_vehicle_id  (tour_id,vehicle_id) UNIQUE
#  index_tour_vehicles_on_vehicle_id              (vehicle_id)
#

class TourVehicle < ApplicationRecord
  belongs_to :vehicle
  belongs_to :tour

  validates :vehicle_id, presence: true
  validates :tour, uniqueness: { allow_blank: false,
                                 scope: :vehicle,
                                 messages: "should have a defined vehicle" }
end
