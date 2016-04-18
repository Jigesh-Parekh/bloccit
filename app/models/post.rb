class Post < ActiveRecord::Base
	belongs_to :topic
	has_many :comments, dependent: :destroy
	#allows post to have many comments related to it
	#provides methods allow to retrieve comments that belong to post


	validates :title, length: {minimum: 5}, presence: true
	validates :body, length: { minimum: 20}, presence: true
	validates :topic, presence: true
end
