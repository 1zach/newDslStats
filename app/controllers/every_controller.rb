class EveryController < ApplicationController
    
    def index
        
        @stats = Stat.all
        if params[:sort] == "k" || params[:sort] == "team"
            @stats = @stats.order("#{params[:sort]} ASC", "years")
        elsif params[:sort] == nil
            @stats
        elsif params[:sort] == "name"
            @stats = @stats.sort_by { |stat| stat.player.name}
        elsif params[:sort] != "k"
            @stats = @stats.order("#{params[:sort]} DESC")
        end

    end
end
