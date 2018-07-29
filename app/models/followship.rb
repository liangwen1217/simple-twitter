class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :following, classname: "User"
end
