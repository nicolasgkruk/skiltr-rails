class Tag < ApplicationRecord
  belongs_to :user
  has_many :sign_tags
  has_many :signs, through: :sign_tags

  validates :title, presence: true, length: { maximum: 255 }
end
