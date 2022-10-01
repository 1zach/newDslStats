module ErasHelper

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

    def avg(player)
      hits = 0
      atbat = 0
      player[1].each do |stat|
        atbat = atbat + stat.atbat
        hits = hits + stat.hits
      end
      return (hits.to_f/ atbat).round(3)
    end

    def slg(player)
      singles = 0
      doubles = 0
      triples = 0
      homers = 0
      atbat = 0
      player[1].each do |stat|
        atbat = atbat + stat.atbat
        singles = singles + stat.singles
        doubles = doubles + stat.doubles
        triples = triples + stat.triples
        homers = homers + stat.homeruns
      end
      slugging = (((singles) + (doubles * 2) + (triples * 3) + (homers * 4)).to_f / (atbat)).round(3)
      return slugging
    end

    def obp(player)
      hits = 0
      atbat = 0
      sac = 0
      player[1].each do |stat|
        atbat = atbat + stat.atbat
        hits = hits + stat.hits
        sac = sac + stat.sac
      end
      onbasep = hits.to_f / (atbat + sac)
      return onbasep.round(3)
    end
    
    def oplus(player)
      opluss = obp(player) + slg(player)
      return opluss.round(3)
    end

    def years(params)
      if params
      yearList = ""
      params.each do |year|
       yearList += "#{year} "
      end
      return yearList
    else
      yearList = "2015"
    end
    end
    
end