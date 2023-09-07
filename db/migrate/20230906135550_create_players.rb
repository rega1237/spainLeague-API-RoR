class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :photo
      t.string :name
      t.string :number
      t.string :position
      t.string :short_team
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
