class AddTeamIdToStatTable < ActiveRecord::Migration[7.0]
  def change
    Stat.find_each do |stat|
      team = Team.find_by(team_name: stat.team)
      stat.update(team_id: team.id) if team
    end
  end
end
