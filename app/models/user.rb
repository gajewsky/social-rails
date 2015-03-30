class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, default_url: '/images/missing.jpg'
  validates :username, presence: true, uniqueness: true
  validates_attachment_content_type :avatar,
                                    content_type: /^image\/(png|gif|jpeg)/,
                                    message: 'Only images allowed'
end
