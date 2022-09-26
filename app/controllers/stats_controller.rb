class StatsController < ApplicationController
    
    def index 
      
        @stats = Stat.all
        @players = Player.all
        if params[:query_seasons]
          @filtered = Player.joins(:seasons).having("seasons.count >= ?", params[:query_seasons])
        elsif params[:previous_seasons]
          @filtered = Player.joins(:seasons).where("seasons.includes(year = 2015)")
        else
          @filtered = Player.joins(:seasons).having("seasons.count >= ?", 6)
        end
        @grouped = @filtered.group(:id)
        if params[:sort] == "seasons.count"
          @sorted = @grouped.sort_by{ |player| [-player.seasons.count, -player.stats.sum(:atbat)]}
        elsif params[:sort] == nil
          @sorted = @grouped.sort_by{ |player| player.name}
        elsif params[:sort] == "name"
          @sorted = @grouped.sort_by{ |player| player.name}
        elsif params[:sort] == "avg"
          @sorted = @grouped.sort_by{ |player| -average(player)}
        elsif params[:sort] == "slg"
          @sorted = @grouped.sort_by{ |player| -slugging(player)}
        elsif params[:sort] != "seasons.count"
          @sorted = @grouped.sort_by{ |player| -player.stats.sum(params[:sort])}
        else
          @sorted = Player.all
      end
      
        
    end

    def show 
        @stat = Stat.find(params[:id])
    end


    def query
      @filtered = Player.joins(:seasons).having("seasons.count >= ?", params[:query_seasons])
    #   @grouped = @filtered.group(:id)
    #     if params[:sort] == "seasons.count"
    #       @sorted = @grouped.sort_by{ |player| [-player.seasons.count, -player.stats.sum(:atbat)]}
    #     elsif params[:sort] == nil
    #       @sorted = @grouped.sort_by{ |player| player.name}
    #     elsif params[:sort] == "name"
    #       @sorted = @grouped.sort_by{ |player| player.name}
    #     elsif params[:sort] == "avg"
    #       @sorted = @grouped.sort_by{ |player| -average(player)}
    #     elsif params[:sort] == "slg"
    #       @sorted = @grouped.sort_by{ |player| -slugging(player)}
    #     elsif params[:sort] != "seasons.count"
    #       @sorted = @grouped.sort_by{ |player| -player.stats.sum(params[:sort])}
    #     else
    #       @sorted = Player.all
    #     end
    end

    def average(player)
      if player.stats.sum(:hits) == 0 || player.stats.sum(:atbat) == 0
          return 0.00
      else
      (player.stats.sum(:hits).to_f / player.stats.sum(:atbat).to_f).round(3)
      end
  end
  
  def slugging(player)
      if player.stats.sum(:atbat) == 0
          return 0.00
      else
      ((player.stats.sum(:singles) + (player.stats.sum(:doubles) * 2) + (player.stats.sum(:triples) * 3) + (player.stats.sum(:homeruns) * 4)).to_f / player.stats.sum(:atbat)).round(3)
      end
  end

end
