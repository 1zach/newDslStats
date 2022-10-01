class SeasonsController < ApplicationController
    
    def index
        if params[:years]
        @players = Stat.where("years = ?", params[:years])
        else
        @players = Stat.where("years = ?", 2022)
        end
          if params[:sort] == nil
            @players = @players.sort_by{ |player| player.player.name}
          elsif params[:sort] == "name"
            if params[:order] == "asc"
              @players = @players.sort_by{ |player| player.player.name}            
            else 
              @players = @players.sort_by{ |player| -player.player.name}            
            end
          elsif params[:sort] != "name"
            if params[:order] == "asc"
            @players = @players.sort_by{ |player| -player[(params[:sort])]}
            else
            @players = @players.sort_by{ |player| player[(params[:sort])]}
            end
          else
            @sorted = Player.all
        end
    end



    def average(player)
        if player.sum(:hits) == 0 || player.sum(:atbat) == 0
            return 0.00
        else
        (player.sum(:hits).to_f / player.sum(:atbat).to_f).round(3)
        end
      end
    
    def slugging(player)
        if player.sum(:atbat) == 0
            return 0.00
        else
        ((player.sum(:singles) + (player.sum(:doubles) * 2) + (player.sum(:triples) * 3) + (player.sum(:homeruns) * 4)).to_f / player.sum(:atbat)).round(3)
        end
    end
  
    def onbase(player)
      if player.sum(:atbat) == 0
        return 0.00
      else
       
        ((player.sum(:singles) + player.sum(:doubles) + player.sum(:triples) + player.sum(:homeruns)).to_f / (player.sum(:atbat) + player.sum(:sac))).to_f.round(3)
      end
    end
  
    def ops(player)
      (onbase(player) + slugging(player)).round(3)
    end
  
end
