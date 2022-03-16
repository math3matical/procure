class Comment < ApplicationRecord
  include Visible

  belongs_to :commentable, polymorphic: true
  validates :commenter, presence: true
  validates :body, presence: true
end
