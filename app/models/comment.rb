class Comment < ApplicationRecord
  include Visible

  belongs_to :commentable, polymorphic: true
end
