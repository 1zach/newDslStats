class Player < ApplicationRecord
    validates :name, uniqueness: true
    has_many :stats
    has_many :seasons, through: :stats
end
