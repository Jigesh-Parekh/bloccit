class Topic < ActiveRecord::Base
   has_many :posts, dependent: :destroy
 # #12
   has_many :labelings, as: :labelable
 # #13
   has_many :labels, through: :labelings
   scope :public_viewable, -> {where(public: true)}
   scope :private_viewable, -> {where(public: false)}
   scope :visible_to, -> (user) {user ? all : public_viewable}

 end