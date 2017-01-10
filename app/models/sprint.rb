class Sprint < ApplicationRecord
  has_many :features
  has_many :sprint_users
  has_many :users, through: :sprint_users
end
