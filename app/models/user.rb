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

  def pending_friend_requests_from
    self.inverse_friendships.where(state: "pending")
  end

  def pending_friend_requests_to
    self.friendships.where(state: "pending")
  end

  def active_friends
    self.friendships.where(state: "active").map(&:friend) 
      + self.inverse_friendships.where(state: "active").map(&:user)
  end

  def friendship_status(user)
    friendship = Friendship.where(
      user_id: [self.id, user.id],
      friend_id: [self.id, user.id]
    )
    unless friendship.any?
      return 'not_friends'
    else
      if friendship.first.state == 'active'
        return 'friends'
      elsif friendship.first.user == self
        return 'pending'
      else
        return 'requested'
      end
    end
  end
end
