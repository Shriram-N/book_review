class Book < ActiveRecord::Base
	searchkick
	acts_as_votable
	belongs_to :user
	has_many :reviews
	has_many :favorite_recipes # just the 'relationships'
    has_many :favorited_by, through: :favorite_recipes, source: :user # the actual users favoriting a recipe



	has_attached_file :image, styles: { medium: "400x600#", thumb: "200x200#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
