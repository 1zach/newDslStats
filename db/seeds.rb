# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
Player.destroy_all
Season.destroy_all
Stat.destroy_all

csv_text = File.read(Rails.root.join('lib', 'seeds', 'allStats.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
puts "Starting"
csv.each do |row|    
            player = Player.new(
                name: row['Name']) 
                player.save
        end
puts "Created #{Player.count} players"

csv.each do |row|
            season = Season.new(
                year: row['Season']
            )        
            season.save
        end
puts "Created #{Season.count} seasons"
csv.each do |row|
    Stat.create(
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
    years: row["Season"],
    player_id: (Player.find_by(name: row["Name"]).id),
    season_id: (Season.find_by(year: row["Season"]).id)
    )
end

        puts "#{Season.all.count}"
        puts "#{Stat.all.count}"


puts "There are now #{Player.all.count} players in the table"
