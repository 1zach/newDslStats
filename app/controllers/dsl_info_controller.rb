class DslInfoController < ApplicationController
    def index
        if params[:gender_toggle] == "0"
            players = Player.where(gender: "f").joins(:stats)
            single_season_player = Stat.joins(:player).where(player: { gender: "f"})
        elsif params[:gender_toggle] == "1"
            players = Player.where(gender: "m").joins(:stats)
            single_season_player = Stat.joins(:player).where(player: { gender: "m"})
        else
           players = Player.where(gender: "m").joins(:stats)
           single_season_player = Stat.joins(:player).where(player: {gender: "f"})
        end
        # females = Player.where(gender: "f").joins(:stats)
        #females_single_season = Stat.joins(:player).where(player: { gender: "f" })

        @games = players.group(:id).sort_by{ |player| -player.stats.sum("games") }
        @games = @games.first(5)
        
        @hits = players.group(:id)
        @hits = @hits.sort_by{ |player| -player.stats.sum("hits")}
        @hits = @hits.first(5)

        @runs = players.group(:id).sort_by{ |player| -player.stats.sum("runs") }
        @runs = @runs.first(5)

        @homers = players.group(:id).sort_by{ |player| -player.stats.sum("homeruns") }
        @homers = @homers.first(5)

        @tb = players.group(:id).sort_by{ |player| -player.stats.sum("tb") }
        @tb = @tb.first(5)

        @avg = players.group(:id).having("stats.count > ?", 3).sort_by{|player| -average(player)}
        @avg = @avg.first(5)
        
        @singlehits = single_season_player.sort_by{|stat| -stat.hits}
        @singlehits = @singlehits.first(5)

        @singleruns = single_season_player.sort_by{|stat| -stat.runs}
        @singleruns = @singleruns.first(5)
        
        @singlerbi = single_season_player.sort_by{|stat| -stat.rbi}
        @singlerbi = @singlerbi.first(5)

        @singlehr = single_season_player.sort_by{|stat| -stat.homeruns}
        @singlehr = @singlehr.first(5)

        @singletb = single_season_player.sort_by{|stat| -stat.tb}
        @singletb = @singletb.first(5)

        @singledoubles = single_season_player.sort_by {|stat| -stat.doubles}.first(5)

        @singleavg = single_season_player.where("atbat >= ?", 25).sort_by { |stat| -stat.avg}.first(5)

        opsPlus_array = single_season_player.where("atbat >= ?", 25).map do |stat|
            [stat, stat.opsPlus]
        end

        sorted_opsPlus = opsPlus_array.sort_by { |pair| -pair[1] }  # Sort in descending order

        @singleopsPlus = sorted_opsPlus.first(5).map(&:first)  # Extracting only the player records

        slgPlus_array = single_season_player.where("atbat>= ?", 20).map do |stat|
            [stat, stat.slgPlus]
        end

        sorted_slgPlus = slgPlus_array.sort_by { |pair| -pair[1]}
        
        @singleslgPlus = sorted_slgPlus.first(5).map(&:first)

        #  respond_to do |format|
        #     format.turbo_stream { render turbo_stream: turbo_stream.replace("leaderboards", partial: "player_leaderboards", locals: { players: players }) }
        #     format.html {render 'index', locals: {players: players}}
        #   end
    end

    def adjusted
        single_season_player = Stat.joins(:player)

        opsPlus_array = single_season_player.where("atbat >= ?", 25).map do |stat|
            [stat, stat.opsPlus]
        end
        sorted_opsPlus = opsPlus_array.sort_by { |pair| -pair[1] }  # Sort in descending order
        @singleopsPlus = sorted_opsPlus.first(25).map(&:first)  # Extracting only the player records
        
        slgPlus_array = single_season_player.where("atbat>= ?", 20).map do |stat|
            [stat, stat.slgPlus]
        end
        sorted_slgPlus = slgPlus_array.sort_by { |pair| -pair[1]}
        @singleslgPlus = sorted_slgPlus.first(25).map(&:first)

    end

    def average(player)
        if player.stats.sum(:hits) == 0 || player.stats.sum(:atbat) == 0
            return 0.00
        else
        avg = (player.stats.sum(:hits).to_d / player.stats.sum(:atbat).to_d)
        avg.round(3)
        end
      end
end
