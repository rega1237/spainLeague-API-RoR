class AddHomeNameAndAwayNameToFixtures < ActiveRecord::Migration[7.0]
  def change
    add_column :fixtures, :home_name, :string
    add_column :fixtures, :away_name, :string
  end
end
