class StatsController < ApplicationController
    
    def index 
      
        @stats = Stat.all
        @players = Player.all
        if params[:query_seasons]
          @filtered = Player.joins(:seasons).having("seasons.count >= ?", params[:query_seasons])
        else
          @filtered = Player.joins(:seasons).having("seasons.count >= ?", 6)
        end
        @grouped = @filtered.group(:id)
        if params[:sort] == "seasons.count"
          if params[:order] == "asc"
            @stated = @grouped.sort_by{ |player| [-player.seasons.count, -player.stats.sum(:atbat)]}
            @sorted = @stated.first(10)
          else 
            @stated = @grouped.sort_by{ |player| [player.seasons.count, player.stats.sum(:atbat)]}
            @sorted = @stated.first(10)
          end
        elsif params[:sort] == nil
          @sorted = @grouped.sort_by{ |player| player.name}
        elsif params[:sort] == "name"
          if params[:order] == "asc"
            @sorted = @grouped.sort_by{ |player| player.name}            
          else 
            @sorted = @grouped.sort_by{ |player| -player.name}            
          end
        elsif params[:sort] == "avg"
          if params[:order] == "asc"
            @sorted = @grouped.sort_by{ |player| -average(player)}
          else 
            @sorted = @grouped.sort_by{ |player| average(player)}
          end
        elsif params[:sort] == "slg"
          if params[:order] == "asc"
            @sorted = @grouped.sort_by{ |player| -slugging(player)}
          else 
            @sorted = @grouped.sort_by{ |player| slugging(player)}
          end
        elsif params[:sort] == "obp"
          if params[:order] == "asc"
            @sorted = @grouped.sort_by{ |player| -onbase(player)}
          else 
            @sorted = @grouped.sort_by{ |player| onbase(player)}
          end
        elsif params[:sort] == "ops"
          if params[:order] == "asc"
            @sorted = @grouped.sort_by{ |player| -ops(player)}
          else 
            @sorted = @grouped.sort_by{ |player| ops(player)}
          end
        elsif params[:sort] != "seasons.count"
          if params[:order] == "asc"
          @sorted = @grouped.sort_by{ |player| -player.stats.sum(params[:sort])}
          else
          @sorted = @grouped.sort_by{ |player| player.stats.sum(params[:sort])}
          end
        else
          @sorted = Player.all
      end
      
        
    end

    def show 
        @stat = Stat.find(params[:id])
    end

private

    def average(player)
      if player.stats.sum(:hits) == 0 || player.stats.sum(:atbat) == 0
          return 0.00
      else
      avg = (player.stats.sum(:hits).to_f / player.stats.sum(:atbat).to_f)
      end
    end
  
  def slugging(player)
      if player.stats.sum(:atbat) == 0
          return 0.00
      else
      ((player.stats.sum(:singles) + (player.stats.sum(:doubles) * 2) + (player.stats.sum(:triples) * 3) + (player.stats.sum(:homeruns) * 4)).to_f / player.stats.sum(:atbat)).round(3)
      end
  end

  def onbase(player)
    if player.stats.sum(:atbat) == 0
      return 0.00
    else
     
      ((player.stats.sum(:singles) + player.stats.sum(:doubles) + player.stats.sum(:triples) + player.stats.sum(:homeruns)).to_f / (player.stats.sum(:atbat) + player.stats.sum(:sac))).to_f.round(3)
    end
  end

  def ops(player)
    (onbase(player) + slugging(player)).round(3)
  end

end
