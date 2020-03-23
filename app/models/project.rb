class Project < ApplicationRecord
  belongs_to :user
  has_many :signs, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 },
            uniqueness: true
end
