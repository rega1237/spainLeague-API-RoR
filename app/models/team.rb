class Team < ApplicationRecord
  has_one :standing
  has_many :home_fixtures, class_name: 'Fixture', foreign_key: 'home_id'
  has_many :away_fixtures, class_name: 'Fixture', foreign_key: 'away_id'
  has_many :players

  def fixtures
    home_fixtures.or(away_fixtures)
  end
end
