class AddTeamstoTeamTable < ActiveRecord::Migration[7.0]
  def change
    #add column team names to table - loop through all stats looking for unique team names
    #add column coaches - foreign_id - make a list of coaches, loop through players, look for players, add their id to table
    add_column(:teams, :team_name, :string)
    add_column(:teams, :coach_id, :bigint)
  end
    
  
end
