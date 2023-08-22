class CreateCoachTable < ActiveRecord::Migration[7.0]
  def change
    create_table :coaches do |t|
      t.text :coach_name
      t.references :player, foreign_key: { to_table: :players, column: :player_id }

      t.timestamps
    end
  end
end
