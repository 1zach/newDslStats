class Stat < ApplicationRecord
   belongs_to :player
   belongs_to :season


   def self.search_by_player_name(query)
      joins(:player).merge(Player.search_by_name(query))
    end
end
