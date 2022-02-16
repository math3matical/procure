class SolutionCoverage < ApplicationRecord
  include Visible

  belongs_to :engineer
  belongs_to :solution

  has_many :comments, as: :commentable
  validates_uniqueness_of :engineer_id, scope: [:solution_id, :engineer_id]
end
