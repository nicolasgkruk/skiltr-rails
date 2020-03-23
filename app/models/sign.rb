class Sign < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_content,
                  against: [:content],
                  using: {
                      tsearch: { any_word: true }
                  }

  belongs_to :user
  belongs_to :project
  has_many :sign_excerpts
  has_many :excerpts, through: :sign_excerpts

  validates :content, presence: true
  validates :project_id, presence: true
end
