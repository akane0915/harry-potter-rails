class Character < ApplicationRecord
  validates :name, :location, :rating, presence: true
  has_many :reviews, dependent: :destroy

  scope :alphabetical, -> { order(name: :asc) }
  scope :creation, -> { order(created_at: :desc) }

  scope :most_reviews, -> {(
    select('characters.name, characters.location, characters.id, count(reviews.id) as reviews_count')
    .joins(:reviews)
    .group("characters.id")
    .order('reviews_count DESC')
    )}
end
