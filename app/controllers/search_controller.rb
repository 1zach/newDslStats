class SearchController < ApplicationController
  def index
     query = params[:search].strip

    if params[:search].present? 
      perform_search_query(query)
      
    else 
      @stats_search = Stat.all
    end      
  end

  private 

  def perform_search_query(search)
    

   @stats_search = params[:search].present? ? Stat.joins(:player).search_by_player_name(params[:search]) : Stat.all
   if params[:sort] == "k" || params[:sort] == "team"
       @stats_search = @stats_search.order("#{params[:sort]} ASC", "years")
   elsif params[:sort] == nil
       @stats_search
   elsif params[:sort] == "name"
       @stats_search = @stats_search.sort_by { |stat| stat.player.name}
   elsif params[:sort] != "k"
       @stats_search = @stats_search.order("#{params[:sort]} DESC")
   end

end
end
