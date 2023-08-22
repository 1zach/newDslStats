class AddCoachesToTeamTable < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :teams, :players, column: :coach_id


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


    teams.map do |team|
      player = Player.find_by(name: team[1])
      p player
      player_id = player.id
      p team[0]
      if player_id.present?
        coaches_team = Team.find_by(team_name: team[0])
        p coaches_team
        if coaches_team.present?
        team.update(coach_id: player_id)
        p coaches_team
        p "#{player.name} coached #{team.team_name}"
        else
          p "No team for #{player.name}"
        end
      end
  end
end
end
