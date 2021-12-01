class Book < ApplicationRecord
	is_impressionable

	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'


	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	scope :create_today, -> { where(created_at: Time.zone.now.all_day) }
	scope :create_yesterday, -> { where(created_at: 1.day.ago.all_day) }
	scope :create_one_week, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }
	scope :create_one_week_ago, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day - 13.day)) }

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
