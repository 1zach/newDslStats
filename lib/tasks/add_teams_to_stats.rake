namespace :add_teams_to_stats do
  desc "Add Teams to Database"
    task team_creation: :environment do
        Stat.all.each do |stat|
          team_string = stat.team_string
          team = Team.find_by(team_name: team_string)
          stat.update(team_id: team.id)
        end
    end
end
