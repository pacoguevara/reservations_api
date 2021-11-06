class Reservation < ApplicationRecord
  belongs_to :vehicle
  belongs_to :service

  validates_presence_of :service_id
  validates_presence_of :start_time
  validates_presence_of :end_time

  accepts_nested_attributes_for :vehicle
end
