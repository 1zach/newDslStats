class AddForeignKeyToTeams < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :teams, :coaches, column: :coach_id

  end
end
