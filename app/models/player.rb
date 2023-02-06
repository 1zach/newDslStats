class Player < ApplicationRecord
    validates :name, uniqueness: true
    has_many :stats, dependent: :destroy
    has_many :seasons, through: :stats


    def totals
        {
            games: self.stats.sum(:games),
        atbat: self.stats.sum(:atbat),
        runs: self.stats.sum(:runs),
        hits: self.stats.sum(:hits),
        singles: self.stats.sum(:singles),
        doubles: self.stats.sum(:doubles),
        triples: self.stats.sum(:triples),
        homeruns: self.stats.sum(:homeruns),
        tb: self.stats.sum(:tb)}
    end

    def season_avg
        obj = self.totals.transform_values {|v| v / self.seasons.count}
        
        
    end

    

end
