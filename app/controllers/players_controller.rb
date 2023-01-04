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
            @stat = @stathistory.sort_by{ |stat| [stat.season.year]}
          elsif params[:sort] != "year" && params[:sort] != nil 
            #@stat = @stathistory
            @stat = @stathistory.order(Arel.sql(params[:sort])).reverse_order
          else
            @stat = @stathistory.sort_by{ |stat| [stat.season.year]}
          end

          @hits = @player.stats.map { |season| [season.years, season.hits]}
          @runs = @player.stats.map { |season| [season.years, season.runs]}
          @avg = @player.stats.map { |season| [season.years, season.avg]}
          @tb = @player.stats.map { |season| [season.years, season.tb]}
          @slg = @player.stats.map {|season| [season.years, (season.slg)]}
          
      def charts(stat)
        @all = Player.joins(:stats).group("id", "name").sum(stat)
        @all = @all.sort_by{ |k, v| -v}
        @all = @all.slice(0,10)
        @all = @all.map {|all| [all[0][1],  all[1]]}
      end
          
    end

  

    
end
