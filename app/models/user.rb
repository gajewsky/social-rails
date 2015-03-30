# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  username               :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  bio                    :text
#  age                    :integer
#  gender                 :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, default_url: '/images/missing.jpg'
  validates :username, presence: true, uniqueness: true
  validates_attachment_content_type :avatar,
                                    content_type: /^image\/(png|gif|jpeg)/,
                                    message: 'Only images allowed'

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships,
           class_name: 'Friendship',
           foreign_key: 'friend_id',
           dependent: :destroy

  def request_friendship(user)
    friendships.create(friend: user)
  end
end
