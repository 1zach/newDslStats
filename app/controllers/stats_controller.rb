class StatsController < ApplicationController
    
    def male 
      players = Player.where(gender: "m").group(:id)
      if params[:query_seasons]
        @grouped = players.joins(:seasons).having("seasons.count >= ?", params[:query_seasons])
      else
        @grouped = players.joins(:seasons).having("seasons.count >= ?", 6)
      end
  
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
      elsif params[:sort] == "obp"
          @sorted = @grouped.sort_by{ |player| -onbase(player)}
      elsif params[:sort] == "ops"
          @sorted = @grouped.sort_by{ |player| -ops(player)}
      elsif params[:sort] != "seasons.count"
        @sorted = @grouped.sort_by{ |player| -player.stats.sum(params[:sort])}
      else
        @sorted = players
    end 
      render 'index'
    end

    def female
      players = Player.where(gender: "f").group(:id)
      filtering_and_sorting(players)
      render 'index'
    end

  def index
    players = Player.all.group(:id)
    filtering_and_sorting(players)
  end
  
  def all 
        players = Player.all.group(:id)
        filtering_and_sorting(players)
        render 'index'
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

  def filtering_and_sorting(players)
    
    if params[:query_seasons]
      @grouped = players.joins(:seasons).having("seasons.count >= ?", params[:query_seasons])
    else
      @grouped = players.joins(:seasons).having("seasons.count >= ?", 6)
    end

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
    elsif params[:sort] == "obp"
        @sorted = @grouped.sort_by{ |player| -onbase(player)}
    elsif params[:sort] == "ops"
        @sorted = @grouped.sort_by{ |player| -ops(player)}
    elsif params[:sort] != "seasons.count"
      @sorted = @grouped.sort_by{ |player| -player.stats.sum(params[:sort])}
    else
      @sorted = players
  end 

  end

end
