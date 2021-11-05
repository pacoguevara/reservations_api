class Customer < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true

  has_many :reservations
  has_many :vehicles
end
