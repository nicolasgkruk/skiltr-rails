class ExcerptTag < ApplicationRecord
  belongs_to :user
  belongs_to :excerpt
  belongs_to :tag
end
