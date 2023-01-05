module PlayersHelper
    def tooltip(local)
        local
    end

    def totals(stat)
        @stat.reduce(0) { |sum, obj| sum + obj[stat.to_sym]}
    end

    def avg()
        hits = @stat.reduce(0) { |sum, obj| sum + obj[:hits]}
        atbat = @stat.reduce(0) { |sum, obj| sum+ obj[:atbat]}
        avg = number_with_precision(hits.to_f/atbat, precision: 3)
        return avg
    end

    def slug()
        singles = @stat.reduce(0) { |sum, obj| sum+ obj[:singles]}
        doubles = @stat.reduce(0) { |sum, obj| sum + obj[:doubles]}
        triples = @stat.reduce(0) { |sum, obj| sum + obj[:triples]}
        homers = @stat.reduce(0) { |sum, obj| sum + obj[:homeruns]}
        atbat = @stat.reduce(0) { |sum, obj| sum + obj[:atbat]}
        number_with_precision((singles + (doubles * 2) + (triples * 3) + (homers * 4)).to_f / atbat, precision: 3)
    end
    
    def obp()
        hits = @stat.reduce(0) { | sum, obj| sum + obj[:hits]}
        atbat = @stat.reduce(0) { | sum, obj| sum + obj[:atbat]}
        sac = @stat.reduce(0) { | sum, obj| sum + obj[:sac]}

        number_with_precision(hits / (atbat + sac).to_f, precision: 3)
    end

    def opslug()
        number_with_precision(obp().to_f + slug().to_f, precision: 3)
    end
    
    
    #   def ops(player)
    #     (onbase(player) + slugging(player)).round(3)
    #   end

end