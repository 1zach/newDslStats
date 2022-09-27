module StatsHelper



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

  def sortable
    params[:order] == "desc" ? params[:order] = "asc" : params[:order] = "desc"     
  end
end