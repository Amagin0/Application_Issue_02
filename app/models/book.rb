class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'


	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
