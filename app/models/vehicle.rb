class Vehicle < ApplicationRecord
  belongs_to :customer
  has_many :reservations

  validates_presence_of :make
  validates_presence_of :model
  validates_presence_of :year

  accepts_nested_attributes_for :customer
end
