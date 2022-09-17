class StatsController < ApplicationController
    require "BigDecimal"
    def index 
        @stats = Stat.all
        @filtered = Player.joins(:seasons).having("seasons.count >= 6")
        @players = Player.all
        @grouped = @filtered.group(:id)
        if params[:sort] == "seasons.count"
          @sorted = @grouped.sort_by{ |player| [-player.seasons.count, -player.stats.sum(:atbat)]}
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
        #@players = Player.group(:id).order(params[:sort])
        
    end

    def show 
        @stat = Stat.find(params[:id])
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
