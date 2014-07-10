class Election < ActiveRecord::Base
  has_many :electoral_races, inverse_of: :election
  has_many :regions, through: :electoral_races
  has_many :candidacies, through: :electoral_races

  validates :name, presence: true

  def days_until_election
    (self.election_date - Date.today).to_i
  end

  def already_occured?
    days_until_election < 0
  end

  def today?
    days_until_election.zero?
  end

  #### CLASS METHODS

  def self.active_election
    find_by(is_active: true)
  end

  def self.active_council_races_order_by_region_name
    active_election.electoral_races
                   .includes(region: :region_type)
                   .where(region_types: { name: 'Council Ward' })
                   .order('regions.name')
  end
end
