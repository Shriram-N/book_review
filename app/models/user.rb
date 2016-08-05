class User < ActiveRecord::Base
	has_and_belongs_to_many :books
	has_many :books
	has_many :reviews , dependent: :destroy

	 # Favorite recipes of user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
