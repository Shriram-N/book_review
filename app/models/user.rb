class User < ActiveRecord::Base
	has_many :books
	has_many :reviews , dependent: :destroy

	 # Favorite recipes of user
  has_many :favorite_recipes # just the 'relationships'
  has_many :favorites, through: :favorite_recipes, source: :recipe # the actual recipes a user favorites

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
