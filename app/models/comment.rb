class Comment < ApplicationRecord
  belongs_to :recipe

  validates :content, presence: true
end
