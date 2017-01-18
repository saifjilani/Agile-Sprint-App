class Sprint < ApplicationRecord
  has_many :features, dependent: :destroy
  has_many :sprint_users, dependent: :destroy
  has_many :users, through: :sprint_users

  validates_associated :features
  validates_associated :sprint_users
  validates_associated :users
  validates_length_of :title, maximum: 50
  validates_presence_of :title, :start_date, :end_date
end
