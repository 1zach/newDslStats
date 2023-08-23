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
              stat.save(validate: false)
              stat.update(team_id: team.id)
            else
              puts "Did not find #{team}"
            end

            if stat.errors.any?
              puts "Error updating stat: #{stat.errors.full_messages.join(', ')}"
            else
              puts "Updated team_id for stat with ID #{stat.id}"
            end
        end
    end
end
