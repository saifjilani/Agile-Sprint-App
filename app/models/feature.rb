class Feature < ApplicationRecord
  belongs_to :sprint
  validates_length_of :title, maximum: 50, allow_blank: true
  validates_presence_of :rank, :estimated_total_hours, :estimated_remaining_hours, :actual_worked_hours
end
