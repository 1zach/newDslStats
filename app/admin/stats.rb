ActiveAdmin.register Stat do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :season, :games, :atbat, :runs, :hits, :singles, :doubles, :triples, :homeruns, :rbi, :k, :tb, :sac, :gwrbi, :avg, :obp, :slg, :ops, :years, :season_id, :player_id, :team
  #
  # or
  #
  permit_params do
    permitted = [:season, :games, :atbat, :runs, :hits, :singles, :doubles, :triples, :homeruns, :rbi, :k, :tb, :sac, :gwrbi, :avg, :obp, :slg, :ops, :years, :season_id, :player_id, :team]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
