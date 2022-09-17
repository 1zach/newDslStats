class AddSeasonToStats < ActiveRecord::Migration[7.0]
  def change
    add_reference :stats, :season, null: false, foreign_key: true
  end
end
