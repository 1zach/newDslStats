class TeamsController < ApplicationController

  def index
    team("index", "all")
  end

  def all
    team("all", "all")
  end

  def coach
    if params[:sort].present?
      new_order = params[:sort]
        if params[:sort] == session[:current_sort]
          session[:current_sort_order] = session[:current_sort_order] == 'asc' ? 'desc' : 'asc'
        else
          session[:current_sort_order] = 'desc'
        end
      else
        new_order = "coach_name"
        session[:current_sort_order] = 'asc'
      end

      session[:current_sort] = params[:sort]
      
      @teams = Stat.joins(team: :coach).select("coach_name")
      .select("
        COUNT(DISTINCT years) as total_years,
        SUM(games) as total_games, 
        SUM(hits) as total_hits, 
        SUM(runs) as total_runs, 
        SUM(atbat) as total_atbats, 
        SUM(singles) as total_singles, 
        SUM(doubles) as total_doubles, 
        SUM(triples) as total_triples, 
        SUM(homeruns) as total_homeruns, 
        SUM(rbi) as total_rbi, 
        SUM(tb) as total_tb, 
        SUM(k) as total_k, 
        SUM(sac) as total_sac, 
        SUM(gwrbi) as total_gwrbi")
      .select(
        "AVG(hits::float / atbat) as avg,
        SUM(hits)::float / NULLIF(SUM(atbat), 0) as obp,
        (SUM(singles) + 2 * SUM(doubles) + 3 * SUM(triples) + 4 * SUM(homeruns))::float / NULLIF(SUM(atbat), 0) as slg,
        (SUM(hits) / SUM(atbat)) + ((SUM(singles) + 2 * SUM(doubles) + 3 * SUM(triples) + 4 * SUM(homeruns))::float / (SUM(atbat))) as ops
      ").group("coach_name")
       .order("#{new_order} #{session[:current_sort_order]}")
    # @teams = @teams.map { |team| {coach_name: team.coach.name}}
  end

  def show
    team_search = Team.find(params[:id])
    team("show", team_search)
  end

  

  private

  def team(page, team)

    group_columns = if page === 'index'
                        [:team_id]
                    elsif page === 'coach' 
                        [:coach_id]
                    else 
                        [:team_id, :years]
                    end
    # group_columns = page == 'index' ? [:team_id] : [:team_id, :years]
    if params[:sort].present?
      new_order = params[:sort]
        if params[:sort] == session[:current_sort]
          session[:current_sort_order] = session[:current_sort_order] == 'asc' ? 'desc' : 'asc'
        else
          session[:current_sort_order] = 'desc'
        end
      else
        new_order = "team_id"
        session[:current_sort_order] = 'asc'
      end

      session[:current_sort] = params[:sort]

      year_column = if page == "index"
        "COUNT(DISTINCT years)"
      elsif page == "all" || "show"
        "years"
      end

      

      @teams = Stat
      .joins(:team)
      .group(*group_columns)
      .where(page == "show" ? {team_id: team} : {})
      .select(" 
        team_id, 
        #{year_column} as total_years,
        SUM(games) as total_games, 
        SUM(hits) as total_hits, 
        SUM(runs) as total_runs, 
        SUM(atbat) as total_atbats, 
        SUM(singles) as total_singles, 
        SUM(doubles) as total_doubles, 
        SUM(triples) as total_triples, 
        SUM(homeruns) as total_homeruns, 
        SUM(rbi) as total_rbi, 
        SUM(tb) as total_tb, 
        SUM(k) as total_k, 
        SUM(sac) as total_sac, 
        SUM(gwrbi) as total_gwrbi")
      .select(
        "AVG(hits::float / atbat) as avg,
        SUM(hits)::float / NULLIF(SUM(atbat), 0) as obp,
        (SUM(singles) + 2 * SUM(doubles) + 3 * SUM(triples) + 4 * SUM(homeruns))::float / NULLIF(SUM(atbat), 0) as slg,
        (SUM(hits) / SUM(atbat)) + ((SUM(singles) + 2 * SUM(doubles) + 3 * SUM(triples) + 4 * SUM(homeruns))::float / (SUM(atbat))) as ops
      ").order("#{new_order} #{session[:current_sort_order]}")
    

  end

  
end
