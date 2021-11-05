class Vehicle < ApplicationRecord
  belongs_to :customer

  validates_presence_of :make
  validates_presence_of :model
  validates_presence_of :year
  validates_presence_of :customer_id
end
