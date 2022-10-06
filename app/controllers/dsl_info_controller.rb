class DslInfoController < ApplicationController
    def index
        @stats = Stat.all
        @players = Player.all
        @seasons = Season.all

        @hits = Player.joins(:stats)
        @hits = @hits.group(:id)
        @hits = @hits.sort_by{ |player| -player.stats.sum("hits")}
        @hits = @hits.first(5)

        @runs = Player.joins(:stats).group(:id).sort_by{ |player| -player.stats.sum("runs") }
        @runs = @runs.first(5)

        @homers = Player.joins(:stats).group(:id).sort_by{ |player| -player.stats.sum("homeruns") }
        @homers = @homers.first(5)

        @tb = Player.joins(:stats).group(:id).sort_by{ |player| -player.stats.sum("tb") }
        @tb = @homers.first(5)

        @avg = Player.joins(:stats).group(:id).having("stats.count > ?", 3).sort_by{|player| -average(player)}
        @avg = @avg.first(5)
        
        @singlehits = Stat.all.sort_by{|stat| -stat.hits}
        @singlehits = @singlehits.first(5)

        @singleruns = Stat.all.sort_by{|stat| -stat.runs}
        @singleruns = @singleruns.first(5)

    end

    def average(player)
        if player.stats.sum(:hits) == 0 || player.stats.sum(:atbat) == 0
            return 0.00
        else
        avg = (player.stats.sum(:hits).to_d / player.stats.sum(:atbat).to_d)
        avg.round(3)
        end
      end
end
