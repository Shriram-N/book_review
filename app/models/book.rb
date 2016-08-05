class Book < ActiveRecord::Base
	has_and_belongs_to_many :users
	searchkick
	acts_as_votable
	belongs_to :user
	belongs_to :category
	has_many :reviews


	has_attached_file :image, styles: { medium: "400x600#", thumb: "200x200#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
