class Sign < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :source
  has_and_belongs_to_many :tags
end
