namespace :team_creation do
  desc "Add Teams to Database"
    task team_creation: :environment do
      
      teams = [["Rippers", "Nash, Eric"],
    ["All Balls", "Waters, Dustin"],
    ["Bus Drivers", "Bolger, Chris"],
    ["Hit Squad", "Johnson, Murray"],
    ["Scoregasms", "Sitar, Corey"],
    ["Pitch Slappers", "Algeo, Bill"],
    ["Sons Of Pitches", "Algeo, Bill"],
    ["Qs", "Mcclure, Rob"],
    ["Spaceballs", "Brown, Brandon"],
    ["Dirtbags", "DeVillers, Gregg"],
    ["Hanamana", "Yantorn, Jayo"],
    ["Game Of Throws", "Jones, Grg"],
    ["Pitch Doctors", "DeVore, Kyle"],
    ["Baker'S Dozen", "Baker, Kory"],
    ["Big Stick Energy", "DeVore, Kyle"],
    ["Dream Catchers", "Baker, Kory"],
    ["Trash Pandas", "Baker, Kory"],
    ["Swingers", "Karalius, Doug"],
    ["Good Times", "Greenough, Jason"],
    ["Los Drinkers", "Rodriguez, Ruben"],
    ["Dingers & Stingers", "Brown, Brandon"],
    ["Field Of Drunks", "Hebb, Chris"],
    ["Overly Defensive", "Rodgers, Ryan"],
    ["Projectile Dysfunction", "DeVore, Kyle"],
    ["The Mavericks", "Brown, Brandon"],
    ["Bats Hit Crazy", "Timpano, Scott"],
    ["Beards And Beavers", "Miller, Mike"],
    ["Good Wood", "DeVore, Kyle"],
    ["Weakened Warriors", "Campbell, Matthew"],
    ["Battered Bastards", "Brown, Brandon"],
    ["Bad News Beers", "Timpano, Scott"],
    ["Hitsters", "Thomas, Zach"],
    ["The Hitsters", "Thomas, Zach"],
    ["Glove Machine", "DeVore, Kyle"],
    ["Vibe Raiders", "DeVore, Kyle"],
    ["C-Ball", "Kuisle, Chris"],
    ["Brew Jays", "Enns, Derek"],
    ["Double Trouble", "Warner, Tim"]]

    teams.each do |team|
      coach = Coach.find_by(name: team[1])
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
