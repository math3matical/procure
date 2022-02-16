class ProvisionTag < ApplicationRecord
  belongs_to :provision_taggable, polymorphic: true
  validates_uniqueness_of :provision_taggable_id, scope: [:provision_taggable_type, :provision_taggable_id]
end
