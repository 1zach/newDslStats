class PlayersController < ApplicationController

    def index
        @players = Player.all
        @filtered = Player.joins(:seasons).where("seasons.count > 7")
        @stats = Stat.all
    end

    def show
        @player = Player.find(params[:id])
        @stathistory = Stat.where(player_id: params[:id])
        #@stathistory = @stathistory.sort_by{ |stat| [-stat.season.year]}
        if params[:sort] == "year"
            @stat = @stathistory.sort_by{ |stat| [stat.years]}
          elsif params[:sort] != "year" && params[:sort] != nil 
            #@stat = @stathistory
            @stat = @stathistory.order(Arel.sql(params[:sort])).reverse_order
          else
            @stat = @stathistory.sort_by{ |stat| [stat.years]}
          end

          def statsaverage(season, category)
            @average = Stat.where("years = ?", season)
            @averagestats = @average.sum(category.to_sym)
            @seasonaveragestat = @averagestats / @average.count
          end

          def avgavg(season)
            average = Stat.where("years = ?", season)
            averagehits = average.sum(:hits)
            averageatbats = average.sum(:atbat)
            helpers.number_with_precision((averagehits / averageatbats.to_f), precision: 3) 
          end
        

          @ab = @player.stats.map { |season| [season.years, season.atbat]}
          @abavg = @player.stats.map { |season| [season.years, statsaverage(season.years, "atbat")]}

          @hits = @player.stats.map { |season| [season.years, season.hits]}
          @hitsavg = @player.stats.map {|season| [season.years, statsaverage(season.years, "hits")]}

          @runs = @player.stats.map { |season| [season.years, season.runs]}
          @runsavg = @player.stats.map { |season| [season.years, statsaverage(season.years, "runs")]}

          @avg = @player.stats.map { |season| [season.years, season.avg]}
          @avgavg = @player.stats.map { |season| [season.years, avgavg(season.years)]}
          

          @tb = @player.stats.map { |season| [season.years, season.tb]}
          @tbavg = @player.stats.map { |season| [season.years, statsaverage(season.years, "tb")]}

          @slg = @player.stats.map { |season| [season.years, season.slg]}

          @hr = @player.stats.map {|season| [season.years, (season.homeruns)]}
          @hravg = @player.stats.map {|season| [season.years, statsaverage(season.years, "homeruns")]}

          @ops = @player.stats.map {|season| [season.years, (season.ops)]}

          @rbi = @player.stats.map {|season| [season.years, (season.rbi)]}
          @rbiavg = @player.stats.map {|season| [season.years, statsaverage(season.years, "rbi")]}
          

          @teams = @player.stats.sort_by {|season| season.years}
          @teams = @teams.map {|season| [season.years, season.team.team_name]}
          @teams = @teams.join(' - ')

          @yearsplayed = @player.stats.map {|season| season.years}
          @yearsplayed = @yearsplayed.sort.join(', ')
          

          
      def charts(stat)
        @all = Player.joins(:stats).group("id", "name").sum(stat)
        @all = @all.sort_by{ |k, v| -v}
        @all = @all.slice(0,10)
        @all = @all.map {|all| [all[0][1],  all[1]]}
      end
          
    end

  

    
end
