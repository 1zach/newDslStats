class ChartsController < ApplicationController
    
    def index
        
        @hits = Player.joins(:stats).group("id", "name").sum("hits")
        @hits = @hits.sort_by{ |k, v| -v}
        @hits = @hits.slice(0,10)
        @hits = @hits.map {|all| [all[0][1],  all[1]]}

         @homeruns = Player.joins(:stats).group(:name).sum("homeruns")
         @homeruns = @homeruns.sort_by { |k, v| -v}
         @homeruns= @homeruns.slice(0, 10)
        
         @runs = Player.joins(:stats).group(:name).sum(:runs)
         @runs = @runs.sort_by {|k, v| -v}
         @runs = @runs.slice(0, 10)

         @tb = Player.joins(:stats).group(:name).sum(:tb)
         @tb = @tb.sort_by {|k, v| -v}
         @tb = @tb.slice(0, 10)

         @rbi = Player.joins(:stats).group(:name).sum(:rbi)
         @rbi = @rbi.sort_by {|k, v| -v}
         @rbi = @rbi.slice(0, 10)

         @doubles = Player.joins(:stats).group(:name).sum(:doubles)
         @doubles = @doubles.sort_by {|k, v| -v}
         @doubles = @doubles.slice(0, 10)
    
        #render json: @stats
    end


end
