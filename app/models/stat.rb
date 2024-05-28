class Stat < ApplicationRecord
   belongs_to :player
   belongs_to :season
   belongs_to :team
   has_one :coach, through: :team


   def self.search_by_player_name(query)
      joins(:player).merge(Player.search_by_name(query))
    end

    def opsPlus
      100*((self.obp/fetch_lg_obp(self.years))+(self.slg/fetch_lg_slg(self.years)-1))
    end

    def slgPlus
      100*(self.slg/fetch_lg_slg(self.years))
    end

    private

    def fetch_lg_obp(year)
      #obp = hits/ab + sf
      stats_for_year = Stat.where(years: year)
      total_hits = stats_for_year.sum(:hits)
      total_at_bats = stats_for_year.sum(:atbat)
      total_sac_fly = stats_for_year.sum(:sac)
      lg_obp = total_hits.to_f / (total_at_bats + total_sac_fly)
    end

    def fetch_lg_slg(year)
      stats_for_year = Stat.where(years: year)
         ((stats_for_year.sum(:singles) + (stats_for_year.sum(:doubles) * 2) + (stats_for_year.sum(:triples) * 3) + (stats_for_year.sum(:homeruns) * 4)).to_f / stats_for_year.sum(:atbat))
     end
end
