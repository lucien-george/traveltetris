class PlanCity < ApplicationRecord
  belongs_to :plan
  belongs_to :city
  accepts_nested_attributes_for :city
end
