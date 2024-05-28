class Season < ApplicationRecord
    validates :year, uniqueness: true
    has_many :stats
    end
