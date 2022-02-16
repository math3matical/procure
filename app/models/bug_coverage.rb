class BugCoverage < ApplicationRecord
  include Visible

  belongs_to :engineer
  belongs_to :bug

  has_many :comments, as: :commentable
  validates_uniqueness_of :engineer_id, scope: [:bug_id, :engineer_id]


end
