class RemoveForeignKeyFromTeamsTable < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :teams, column: :coach_id
  end
end
