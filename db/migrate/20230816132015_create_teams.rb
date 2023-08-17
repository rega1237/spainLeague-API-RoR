class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :shield
      t.string :stadium
      t.string :year
      t.string :president
      t.string :site

      t.timestamps
    end
  end
end
