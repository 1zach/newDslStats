class AddDataToCoachesTable < ActiveRecord::Migration[7.0]
  def change

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

    coaches = teams.map { |team, name| name }.uniq

    coaches.each do |name|
      player = Player.find_by(name: name)
      
      if player
        Coach.create(coach_name: name, player_id: player.id)
      else
        # Handle the case where the player with the given name is not found
        p name
      end
    end
  end
end
