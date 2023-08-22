class Coach < ApplicationRecord
  has_many :teams
  has_many :stats, through: :teams
end
