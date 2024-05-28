namespace :add_teams do
  desc "Add 2024 Teams to Database"
    task new_teams: :environment do
      
    teams = [
    ["Bees", "Warner, Tim"],
    ["Alcoballics", "Dalton, Elvie"]]

    teams.each do |team|
      if Coach.find_by(coach_name: team[1])
        coach = Coach.find_by(coach_name: team[1])
      else
        new_coach = Coach.new(coach_name: team[1], player_id: Player.find_by(name: team[1]).id)
        
        p new_coach
        new_coach.save
        p "Successfully saved new coach!"
      end
      coach = Coach.find_by(coach_name: team[1])
      p coach
        unless Team.exists?(team_name: team[0])
          team = Team.create(team_name: team[0], coach_id: coach.id)

          if team.errors.any?
            puts "Errors: #{team.errors.full_messages.join(', ')}"
          else
            puts "#{team.team_name} Team created successfully!"
          end
          
        end
      end
    end
end