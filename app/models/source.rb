class Source < ApplicationRecord
  belongs_to :user
  has_many :excerpts, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :author, length: { maximum: 255 }
end
