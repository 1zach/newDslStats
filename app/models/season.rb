class Season < ApplicationRecord
    validates :year, uniqueness: true
    has_many :stats
    belongs_to :player
end
