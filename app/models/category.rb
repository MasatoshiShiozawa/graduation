class Category < ApplicationRecord
  validates :name, presence: true
  has_many :special_category_relations, dependent: :destroy
  has_many :specials, through: :special_category_relations
end
