class YearsController < ApplicationController
  def index

    if params[:sort].present?
      new_order = params[:sort]
        if params[:sort] == session[:current_sort]
          session[:current_sort_order] = session[:current_sort_order] == 'asc' ? 'desc' : 'asc'
        else
          session[:current_sort_order] = 'desc'
        end
      else
        new_order = "year"
        session[:current_sort_order] = 'asc'
      end

      session[:current_sort] = params[:sort]


    @years = Stat.select("
      years as year,
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
      "SUM(hits::float) / SUM(atbat) as avg,
      SUM(hits)::float / (NULLIF(SUM(atbat), 0) + SUM(sac)) as obp,
      (SUM(singles) + 2 * SUM(doubles) + 3 * SUM(triples) + 4 * SUM(homeruns))::float / NULLIF(SUM(atbat), 0) as slg,
      (SUM(hits)::float / NULLIF(SUM(atbat), 0) + (SUM(singles) + 2 * SUM(doubles) + 3 * SUM(triples) + 4 * SUM(homeruns))::float / NULLIF(SUM(atbat), 0)) as ops")
      .group("years").order("#{new_order} #{session[:current_sort_order]}")

    @years_data = @years.each_with_object({}) do |year, data|
      data[(year.year)] = year.ops
    end
    end

    
end
