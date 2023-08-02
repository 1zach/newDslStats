class Player < ApplicationRecord
    include ActionView::Helpers::NumberHelper
    include PgSearch::Model

    validates :name, uniqueness: true
    has_many :stats, dependent: :destroy
    has_many :seasons, through: :stats

    

    pg_search_scope :search_by_name,
                    against: [:name],
                    using: {
                        :tsearch => {prefix: true},
                        :trigram => {threshold: 0.3}
                    }
                      


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

    def avg
        hits = self.stats.sum(:hits)
        atbat = self.stats.sum(:atbat)
        avg = hits.to_f/atbat
        stringavg = avg.to_s
        stringavg.slice!(2, 3).to_i / 1000.to_f
        
    end

end
