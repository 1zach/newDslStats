namespace :team_creation do
  desc "Add Teams to Database"
    task team_creation: :environment do
      Stat.all.each do |stat|
        p stat.team_string
        team_name = stat.team_string
        p team_name
        unless Team.exists?(team_name: team_name)
          team = Team.create(team_name: team_name)
          p team.team_name
        end
      end
    end
end
