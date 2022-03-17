class EngineerTag < ApplicationRecord
  include Visible
 
  belongs_to :engineer_taggable, polymorphic: true

   belongs_to :engineer

  validates_uniqueness_of :engineer_id, scope: [:engineer_taggable_type, :engineer_taggable_id]
  validates :engineer_id, presence: true
end
