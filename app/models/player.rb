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
        rbi: self.stats.sum(:rbi),
        singles: self.stats.sum(:singles),
        doubles: self.stats.sum(:doubles),
        triples: self.stats.sum(:triples),
        homeruns: self.stats.sum(:homeruns),
        tb: self.stats.sum(:tb),
        }
    end

    def season_avg
        obj = self.totals.transform_values {|v| v / self.seasons.count}
    end

    def avg
        hits = self.stats.sum(:hits)
        atbat = self.stats.sum(:atbat)
        avg = hits.to_f/atbat
        avg = number_with_precision(avg, precision: 3).to_f
    end

    def slg
        singles = self.stats.sum(:singles)
        doubles = self.stats.sum(:doubles)
        triples = self.stats.sum(:triples)
        homeruns = self.stats.sum(:homeruns)
        atbats = self.stats.sum(:atbat)
        slg = (singles + 2*doubles + 3*triples + 4*homeruns) / atbats.to_f
        slg = number_with_precision(slg, precision: 3).to_f
    end

    def obp
        hits = self.stats.sum(:hits)
        atbats = self.stats.sum(:atbat)
        sac = self.stats.sum(:sac)
        obp = hits / (atbats + sac).to_f
        obp = number_with_precision(slg, precision: 3).to_f
    end


end
