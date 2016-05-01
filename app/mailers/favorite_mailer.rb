class FavoriteMailer < ApplicationMailer
	default from: "Jparekh117@gmail.com"

    def new_comment(user, post, comment)
 
 # #18
     headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
     headers["References"] = "<post/#{post.id}@your-app-name.example>"
 
     @user = user
     @post = post
     @comment = comment
 
 # #19
     mail(to: "Jparekh117@gmail.com", subject: "New comment on #{post.title}")
   end
end
