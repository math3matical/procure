class CaseCoverage < ApplicationRecord
  include Visible

  belongs_to :engineer
  belongs_to :case

  has_many :comments, as: :commentable
  validates_uniqueness_of :engineer_id, scope: [:case_id, :engineer_id]

  validates :case_id, presence: true
  validates :engineer_id, presence: true

end
