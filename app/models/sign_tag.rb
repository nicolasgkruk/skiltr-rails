class SignTag < ApplicationRecord
  belongs_to :user
  belongs_to :sign
  belongs_to :tag
end
