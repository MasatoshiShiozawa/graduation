class Special < ApplicationRecord
    validates :product, presence: true
    validates :company, presence: true
    validates :detail, presence: true
    validates :per, numericality: { :greater_than => 0 }
    validates :status, presence: true
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0}

    mount_uploader :image, ImageUploader
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :suiis, dependent: :destroy
    has_many :special_category_relations, dependent: :destroy
    has_many :categories, through: :special_category_relations
    # enum status: { '割安': 0, '並': 1, '割高': 2 }
end
