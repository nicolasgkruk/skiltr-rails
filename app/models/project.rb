class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :sources
  has_and_belongs_to_many :tags

  validates :title, presence: true, length: { maximum: 255 },
            uniqueness: true
end
