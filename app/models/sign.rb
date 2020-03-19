class Sign < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :sign_excerpts, dependent: :destroy
  has_many :excerpts, through: :sign_excerpts

  validates :source, presence: true
  validates :content, presence: true
  validates :project_id, presence: true
end
