class Add2024PlayersAndStats < ActiveRecord::Migration[7.0]
  def change
    
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
          
    
    csv_text = File.read(Rails.root.join('lib', 'seeds', '2024Stats.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    puts "Starting"
    csv.each do |row|    
                player = Player.new(
                    name: row['Name'],
                    gender: row['Gender']) 
                    player.save
                    p player
            end
    puts "Created #{Player.count} players"
    
    
                season = Season.new(
                    year: 2024
                )        
                season.save
              
          
    puts "Created #{season} season "
    csv.each do |row|
        stat = Stat.create(
        team_id: Team.find_by(team_name: row['Team']).id,
        games: row['G'],
        atbat: row["AB"],
        runs: row["R"],
        hits: row["H"],
        singles: row["1b"],
        doubles: row["2b"],
        triples: row["3b"],
        homeruns: row["HR"],
        rbi: row["RBI"],
        k: row["K"],
        tb: row["TB"],
        sac: row["SAC"],
        gwrbi: row["GWrbi"],
        avg: row["Avg"],
        obp: row["OBP"],
        slg: row["Slg"],
        ops: row["OPS"],
        years: 2024,
        player_id: (Player.find_by(name: row["Name"]).id),
        season_id: Season.last.id,
        )
        if stat.save
          p stat
        else
          p stat
          p stat.errors.full_messages.join(', ')
          puts "Stat for player did not save"
        end
    end
    
            puts "#{Season.all.count}"
            puts "#{Stat.all.count}"
    
    
    puts "There are now #{Player.all.count} players in the table"
  end
end
