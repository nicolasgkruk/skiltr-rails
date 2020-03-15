class Source < ApplicationRecord
  belongs_to :user
  has_many :signs, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :author, length: { maximum: 255 }
end
