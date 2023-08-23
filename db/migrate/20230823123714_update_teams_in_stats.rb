class UpdateTeamsInStats < ActiveRecord::Migration[7.0]
  def change
    rename_column :stats, :team, :team_string
  end
end
