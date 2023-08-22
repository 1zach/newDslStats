class ExportPlayersToCsv < ActiveRecord::Migration[7.0]
  def change
    require 'csv'

    

    players = Player.all

    CSV.open('players.csv', 'w', write_headers: true, headers: players.first.attributes.keys) do |csv|
      players.each do |player|
        csv << player.attributes.values
      end
    end
  end
end
