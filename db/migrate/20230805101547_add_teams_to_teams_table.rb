class AddTeamsToTeamsTable < ActiveRecord::Migration[7.0]
  def change
    Stat.find_each(batch_size: 1000) do |stat|
      team_name = stat.team

      unless Team.exists?(team_name: team_name)
        team = Team.create(team_name: team_name)
        p team.team_name
      end
    end
      
  end
end
