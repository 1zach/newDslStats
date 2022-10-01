class EveryController < ApplicationController
    
    def index
        
        @stats = Stat.all
        if params[:sort] == "k"
            @stats = @stats.order("#{params[:sort]} ASC")
        elsif params[:sort] == nil
            @stats
        elsif params[:sort] != "k"
            @stats = @stats.order("#{params[:sort]} DESC")
        end

    end
end
