class AddTeamIdToStats < ActiveRecord::Migration[7.0]
  def change
    add_reference :stats, :team, foreign_key: true
  end
end
