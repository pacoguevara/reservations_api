class Reservation < ApplicationRecord
  belongs_to :vehicle
  belongs_to :service

  validates_presence_of :service_id
  validates_presence_of :start_time
  validates_presence_of :end_time

  accepts_nested_attributes_for :vehicle

  def valid_timeslot?
    reservations = Reservation.where(start_time: self.start_time.midnight..self.start_time.end_of_day)
                              .where.not(id: self.id)
                              .order(:start_time)
    reservations.each do |reservation|
      start_arr = [self.start_time, reservation.start_time]
      end_arr = [self.end_time, reservation.end_time]
      return false if start_arr.max < end_arr.min
    end
    true
  end
end
