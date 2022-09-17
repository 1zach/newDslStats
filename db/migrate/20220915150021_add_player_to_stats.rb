class AddPlayerToStats < ActiveRecord::Migration[7.0]
  def change
    add_reference :stats, :player, null: false, foreign_key: true
  end
end
