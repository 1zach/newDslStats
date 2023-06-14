namespace :import_stats do
  desc "Imports new stats"
  task stats: :environment do
    csv_text = File.read(Rails.root.join('lib', 'seeds', '2023Stats.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    puts "Starting"
    csv.each do |row|    
                player = Player.new(
                    name: row['Name']) 
                    player.save
                    p player
            end
    puts "Created #{Player.count} players"
    
    
                season = Season.new(
                    year: 2023
                )        
                season.save
              
          
    puts "Created #{season} season"
    csv.each do |row|
        stat = Stat.create(
        team: row['Team'],
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
        years: 2023,
        player_id: (Player.find_by(name: row["Name"]).id),
        season_id: 9
        )
        p stat
    end
    
            puts "#{Season.all.count}"
            puts "#{Stat.all.count}"
    
    
    puts "There are now #{Player.all.count} players in the table"
  end
end
