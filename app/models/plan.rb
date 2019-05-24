class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :city
  has_many :trip_dates
  has_many :plan_cities
  has_many :cities, through: :plan_cities
  accepts_nested_attributes_for :plan_cities
end
