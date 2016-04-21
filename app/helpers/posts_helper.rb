module PostsHelper
	def user_is_authorized_for_post?(post)
		current_user && (current_user == post.user || current_user.admin?)
	end
	#checks if there is a signed in current user and if current user owns the post or is the admin
    def user_is_authorized_for_post_as_mod?(post)
		current_user.moderator?
	end

end
