class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :catch

  validates :comment, presence: true
end
