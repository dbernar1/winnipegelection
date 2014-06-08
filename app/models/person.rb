class Person < ActiveRecord::Base
  has_many :candidacies, inverse_of: :person
  has_many :electoral_races, through: :candidacies

  validates :name, presence: true
  validates :website, :council_site, :facebook, :twitter, :youtube, :linkedin,
            url: { allow_blank: true }

  mount_uploader :image, ProfileImageUploader

  include FriendlyURL
  def slug_for_friendly_url
    name.parameterize
  end
end
