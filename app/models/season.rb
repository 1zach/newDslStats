class Season < ApplicationRecord
    validates :year, uniqueness: true
    end
