class EveryController < ApplicationController
    
    def index

        ordered_stats = Stat.joins(:player).order(:name, :years)

        if params[:clear].present?
            @stats=ordered_stats
        end

        if params[:search].present?
            perform_search_query(params[:search])
        else
            @stats = ordered_stats
        end

        if params[:sort] == "k" || params[:sort] == "team"
            @stats = @stats.order("#{params[:sort]} ASC", "years")
        elsif params[:sort] == nil
            @stats.order(:name, :years)
        elsif params[:sort] == "name"
            @stats = @stats.sort_by { |stat| stat.player.name}
        elsif params[:sort] != "k"
            @stats = @stats.order("#{params[:sort]} DESC")
        end
        
    end

    def perform_search_query(search)
        @stats = Stat.joins(:player).where("players.name ILIKE :search OR players.name ILIKE :flipped_search",
            search: "%#{search}%",
            flipped_search: "%#{search.split.reverse.join(', ')}%")
    end

end
