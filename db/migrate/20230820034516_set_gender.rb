class SetGender < ActiveRecord::Migration[7.0]
  def change
    players = Player.all
    players.each do |player|
      player.update(gender: "m")
    end
  end
end
