namespace :add_teams_to_stats do
  desc "Add Teams to Database"
    task team_creation: :environment do
        Stat.all.each do |stat|
          team_string = stat.team_string
            if team_string
              puts "Found #{team_string}"
            else
              puts "Did not find #{stat.team_string}"
           end
          team = Team.find_by(team_name: team_string)
            if team
              puts "Found #{team} in database"
            else
              puts "Did not find #{team}"
            end
          stat.update(team_id: team.id)
          
        end
    end
end
