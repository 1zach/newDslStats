class Player < ApplicationRecord
    validates :name, uniqueness: true
    has_many :stats, dependent: :destroy
    has_many :seasons, through: :stats
end
