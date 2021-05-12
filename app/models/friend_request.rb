class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  def accept
    sender.friends << receiver
    receiver.friends << sender
    self.destroy
  end

  def decline
    self.destroy
  end
end
