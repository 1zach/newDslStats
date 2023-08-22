class Team < ApplicationRecord
  has_many :stats
  belongs_to :coach


  validates :team_name, uniqueness: true

end
