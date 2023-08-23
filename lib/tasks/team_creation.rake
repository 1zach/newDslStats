namespace :team_creation do
  desc "Add Teams to Database"
    task :team_creation do
      Stat.all do |stat|
        team_name = stat.team_string
        unless Team.exists?(team_name: team_name)
          team = Team.create(team_name: team_name)
          p team.team_name
        end
      end
    end
end
