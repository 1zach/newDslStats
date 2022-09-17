class AddYearsColumnToStats < ActiveRecord::Migration[7.0]
  def change
    add_column(:stats, :years, :integer)
  end
end
