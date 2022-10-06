class AddTeamColumnToStats < ActiveRecord::Migration[7.0]
  def change
    add_column(:stats, :team, :string)
  end
end
