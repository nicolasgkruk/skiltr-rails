class SignExcerpt < ApplicationRecord
  belongs_to :user
  belongs_to :excerpt
  belongs_to :sign
end
