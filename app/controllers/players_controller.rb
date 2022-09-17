class PlayersController < ApplicationController

    def index
        @players = Player.all
        @filtered = Player.joins(:seasons).where("seasons.count > 7")
        @stats = Stat.all
    end

    def show
        @player = Player.find(params[:id])
        @stathistory = Stat.where(player_id: params[:id])
        @stathistory = @stathistory.sort_by{ |stat| [-stat.season.year]}

        if params[:sort] == "year"
            @stat = @stathistory.sort_by{ |stat| [-stat.season.year]}
          elsif params[:sort] != "year"
            @stat = @stathistory
            #@stat = @stathistory.sort_by{ |stat| -stat.(params[:sort])}
          else
            @stat = @stathistory.sort_by{ |stat| [-stat.season.year]}
          end


    end
end
