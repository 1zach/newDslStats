class Stat < ApplicationRecord
   belongs_to :player
   belongs_to :season
   belongs_to :team
   belongs_to :coach


   def self.search_by_player_name(query)
      joins(:player).merge(Player.search_by_name(query))
    end
end
