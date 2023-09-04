class CreateFixtures < ActiveRecord::Migration[7.0]
  def change
    create_table :fixtures do |t|
      t.string :matchday
      t.string :hour
      t.string :day
      t.string :result
      t.references :home, null: false, foreign_key: { to_table: :teams }
      t.references :away, null: false, foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
