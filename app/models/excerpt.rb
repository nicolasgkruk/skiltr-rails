class Excerpt < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_content,
                  against: [:content],
                  using: {
                      tsearch: { any_word: true }
                  }

  belongs_to :user
  belongs_to :source
  has_many :excerpt_tags, dependent: :destroy
  has_many :tags, through: :excerpt_tags

  validates :content, presence: true
  validates :source_id, presence: true
end
