class DslInfoController < ApplicationController
    def index
        @stats = Stat.all
        @players = Player.all
        @seasons = Season.all

        females = Player.where(gender: "f").joins(:stats)
        females_single_season = Stat.joins(:player).where(player: { gender: "f" })

        @games = females.group(:id).sort_by{ |player| -player.stats.sum("games") }
        @games = @games.first(5)
        
        @hits = females.group(:id)
        @hits = @hits.sort_by{ |player| -player.stats.sum("hits")}
        @hits = @hits.first(5)

        @runs = females.group(:id).sort_by{ |player| -player.stats.sum("runs") }
        @runs = @runs.first(5)
        

        @homers = females.group(:id).sort_by{ |player| -player.stats.sum("homeruns") }
        @homers = @homers.first(5)

        @tb = females.group(:id).sort_by{ |player| -player.stats.sum("tb") }
        @tb = @tb.first(5)

        @avg = females.group(:id).having("stats.count > ?", 3).sort_by{|player| -average(player)}
        @avg = @avg.first(5)
        
        @singlehits = females_single_season.sort_by{|stat| -stat.hits}
        @singlehits = @singlehits.first(5)

        @singleruns = females_single_season.sort_by{|stat| -stat.runs}
        @singleruns = @singleruns.first(5)
        
        @singlerbi = females_single_season.sort_by{|stat| -stat.rbi}
        @singlerbi = @singlerbi.first(5)

        @singlehr = females_single_season.sort_by{|stat| -stat.homeruns}
        @singlehr = @singlehr.first(5)

        @singletb = females_single_season.sort_by{|stat| -stat.tb}
        @singletb = @singletb.first(5)

         @singledoubles = females_single_season.sort_by {|stat| -stat.doubles}.first(5)

         @singleavg = females_single_season.sort_by { |stat| -stat.avg}.first(5)
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
