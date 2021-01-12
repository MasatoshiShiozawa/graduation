class Special < ApplicationRecord
    validates :product, presence: true
    mount_uploader :image, ImageUploader
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :suiis, dependent: :destroy
end
