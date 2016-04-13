class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	#allows post to have many comments related to it
	#provides methods allow to retrieve comments that belong to post
end
