class EveryController < ApplicationController

    def index

        ordered_stats = Stat.joins(:player).order(:name, :years).where(gender: "f")

        if params[:gender_toggle] == "0"
            players = Player.where(gender: "f").joins(:stats)
        elsif params[:gender_toggle] == "1"
            players = Player.where(gender: "m").joins(:stats)
        else
           players = Player.where(gender: "f").joins(:stats)
        end
        
        if params[:clear].present?
            @stats=perform_search_query("")
        elsif params[:search].present?
           @stats = perform_search_query(params[:search])
        else
            @stats = perform_search_query("")
        end

        if params[:sort] == "k" || params[:sort] == "team"
            @stats = @stats.order("#{params[:sort]} ASC", "years")
        elsif params[:sort] == nil
            @stats = @stats.order(:name, :years)
        elsif params[:sort] == "name"
            @stats = @stats.sort_by { |stat| stat.player.name}
        elsif params[:sort] != "k"
            @stats = @stats.order("#{params[:sort]} DESC")
        end

       

        @pagy, @stats = pagy(@stats)
        
    end

    def perform_search_query(search)
        if params[:gender_toggle].present?
            if params[:gender_toggle] == "0"
                @stats = Stat.joins(:player).where("players.name ILIKE :search OR players.name ILIKE :flipped_search",
                search: "%#{search}%",
                flipped_search: "%#{search.split.reverse.join(', ')}%").where("players.gender = 'f'")
            elsif params[:gender_toggle] == "1"
                @stats = Stat.joins(:player).where("players.name ILIKE :search OR players.name ILIKE :flipped_search",
                search: "%#{search}%",
                flipped_search: "%#{search.split.reverse.join(', ')}%").where("players.gender = 'm'")
            end
        else
            @stats = Stat.joins(:player).where("players.name ILIKE :search OR players.name ILIKE :flipped_search",
                search: "%#{search}%",
                flipped_search: "%#{search.split.reverse.join(', ')}%")
        end
    end

end
