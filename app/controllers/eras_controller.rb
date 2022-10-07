class ErasController < ApplicationController
    def index
        if params[:years]
           if params[:years].length == 1
               @players = Stat.where("years = ?", params[:years][0])
             elsif params[:years].length == 2
               @players = Stat.where("years = ?", params[:years][0]).or(Stat.where("years = ?", params[:years][1]))
            elsif params[:years].length == 3
              @players = Stat.where("years = ?", params[:years][0]).or(Stat.where("years = ?", params[:years][1])).or(Stat.where("years = ?", params[:years][2]))
            elsif params[:years].length == 4
              @players = Stat.where("years = ?", params[:years][0]).or(Stat.where("years = ?", params[:years][1])).or(Stat.where("years = ?", params[:years][2])).or(Stat.where("years =?", params[:years][3]))
            elsif params[:years].length == 5
              @players = Stat.where("years = ?", params[:years][0]).or(Stat.where("years = ?", params[:years][1]))
              .or(Stat.where("years = ?", params[:years][2])).or(Stat.where("years =?", params[:years][3]))
              .or(Stat.where("years = ?", params[:years][4]))
            elsif params[:years].length == 6
              @players = Stat.where("years = ?", params[:years][0]).or(Stat.where("years = ?", params[:years][1]))
              .or(Stat.where("years = ?", params[:years][2])).or(Stat.where("years = ?", params[:years][3]))
              .or(Stat.where("years = ?", params[:years][4])).or(Stat.where("years = ?", params[:years][5]))
            elsif params[:years].length == 7
              @players = Stat.where("years = ?", params[:years][0]).or(Stat.where("years = ?", params[:years][1]))
              .or(Stat.where("years = ?", params[:years][2])).or(Stat.where("years = ?", params[:years][3]))
              .or(Stat.where("years = ?", params[:years][4])).or(Stat.where("years = ?", params[:years][5]))
              .or(Stat.where("years = ?", params[:years][6]))
            elsif params[:years].length == 7
              @players = Stat.where("years = ?", params[:years][0]).or(Stat.where("years = ?", params[:years][1]))
              .or(Stat.where("years = ?", params[:years][2])).or(Stat.where("years = ?", params[:years][3]))
              .or(Stat.where("years = ?", params[:years][4])).or(Stat.where("years = ?", params[:years][5]))
              .or(Stat.where("years = ?", params[:years][6])).or(Stat.where("years = ?", params[:years][7]))
            end
            
            if !params[:sort]
              if params[:order] == "asc" 
                @grouped = @players.group_by { |player| -player.player.name}
              else
                @grouped = @players.group_by { |player| player.player.name}
              end
            elsif params[:sort] == "seasons.count"
              
              #@grouped = @players.group(:id)
              #@grouped = @grouped.group_by { |player| (player[1]).sum.atbat}
              @grouped = @players.group_by { |player| player.player.name}
              @grouped = @grouped.sort_by { |player| [-player[1].count, player[0]]}
            
            else
             @players = Stat.where("years = 2015")
             @grouped = @players.group_by { |player| player.player.name}
            end
          end
        # else
        #      @players = Stat.where("years = 2015")
        #      @grouped = @players.group_by { |player| player.player.name}
        
      end


    def games(player)
      games = 0
      player[1].each do |stat|
      games = games + stat.games
      end
      return games
    end

    def atbat(player)
      atbat = 0
      player[1].each do |stat|
      atbat = atbat + stat.atbat
      end
      return atbat
    end

    def hits(player)
      hits = 0
      player[1].each do |stat|
      hits = hits + stat.hits
      end
      return hits
    end

    def runs(player)
      runs = 0
      player[1].each do |stat|
      runs = runs + stat.runs
      end
      return runs
    end

    def singles(player)
      singles = 0
      player[1].each do |stat|
      singles = singles + stat.singles
      end
      return singles
    end

    def doubles(player)
      doubles = 0
      player[1].each do |stat|
      doubles = doubles + stat.doubles
      end
      return doubles
    end

    def triples(player)
      triples = 0
      player[1].each do |stat|
      triples = triples + stat.triples
      end
      return triples
    end

    def homers(player)
      homeruns = 0
      player[1].each do |stat|
        homeruns = homeruns + stat.homeruns
        end
        return homeruns
    end

    def rbi(player)
      rbi = 0
      player[1].each do |stat|
        rbi = rbi + stat.rbi
        end
        return rbi
    end

    def total_bases(player)
      tb = 0
      player[1].each do |stat|
        tb = tb + stat.tb
        end
        return tb
    end

    def k(player)
      k = 0
      player[1].each do |stat|
        k = k + stat.k
        end
        return k
    end

    def sac(player)
      sac = 0
      player[1].each do |stat|
        sac = sac + stat.sac
        end
        return sac
    end

    def gw(player)
      gw = 0
      player[1].each do |stat|
        gw = gw + stat.gwrbi
        end
        return gw
    end
end
