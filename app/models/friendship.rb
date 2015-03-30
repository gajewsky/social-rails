# == Schema Information
#
# Table name: friendships
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  friend_integer :string
#  state          :string           default("pending")
#  friended_at    :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept_friendship
    update(state: 'ative', friended_at: Time.now)
  end

  def deny_friendship
    destroy
  end

  def cancel_friendship
    destroy
  end
end
