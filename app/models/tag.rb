class Tag < ApplicationRecord
  belongs_to :user
  has_many :excerpt_tags, dependent: :destroy
  has_many :excerpts, through: :excerpt_tags

  validates :title, presence: true, length: { maximum: 255 }
end
