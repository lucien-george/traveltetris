class City < ApplicationRecord
	has_many :plan_cities
	has_many :plans, through: :plan_cities
end
