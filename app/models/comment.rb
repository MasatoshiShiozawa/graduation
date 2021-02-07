class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :special
  belongs_to :user
end
