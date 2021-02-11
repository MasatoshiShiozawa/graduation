class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_specials, through: :favorites, source: :special
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
