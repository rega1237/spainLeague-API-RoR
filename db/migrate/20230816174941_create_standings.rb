class CreateStandings < ActiveRecord::Migration[7.0]
  def change
    create_table :standings do |t|
      t.string :name_for_table
      t.string :played
      t.string :won
      t.string :draw
      t.string :lose
      t.string :goals_for
      t.string :goals_against
      t.string :points
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
