class UpdateGenders < ActiveRecord::Migration[7.0]
  def change
    require 'csv'
  CSV.foreach('players.csv', headers: true) do |row|
  p row
    player = Player.find_by(name: row['name'])
  player.update(gender: row['gender'])
  p "Name: #{player.name} Gender: #{player.gender}"
    end
  end
end
