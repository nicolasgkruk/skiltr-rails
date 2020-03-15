class Sign < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_content_and_excerpt,
                  against: [:content, :excerpt],
                  using: {
                      tsearch: { prefix: true }
                  }

  belongs_to :user
  belongs_to :project
  belongs_to :source
  has_many :sign_tags, dependent: :destroy
  has_many :tags, through: :sign_tags

  validates :source, presence: true
  validates :excerpt, presence: true
  validates :project_id, presence: true
  validates :source_id, presence: true
end
