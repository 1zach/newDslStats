class AddGenderToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column(:players, :gender, :string)
  end
end
