class Post < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :labelings, as: :labelable
    has_many :labels, through: :labelings

	#allows post to have many comments related to it
	#provides methods allow to retrieve comments that belong to post

	default_scope {order('created_at DESC')}

	validates :title, length: {minimum: 5}, presence: true
	validates :body, length: { minimum: 20}, presence: true
	validates :topic, presence: true
	validates :user, presence: true
end
