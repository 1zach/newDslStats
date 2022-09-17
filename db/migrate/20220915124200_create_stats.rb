class CreateStats < ActiveRecord::Migration[7.0]
  def change
    create_table :stats do |t|
      t.integer :season
      t.integer :games
      t.integer :atbat
      t.integer :runs
      t.integer :hits
      t.integer :singles
      t.integer :doubles
      t.integer :triples
      t.integer :homeruns
      t.integer :rbi
      t.integer :k
      t.integer :tb
      t.integer :sac
      t.integer :gwrbi
      t.float :avg
      t.float :obp
      t.float :slg
      t.float :ops
      

      t.timestamps
    end
  end
end
