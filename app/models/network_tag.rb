class NetworkTag < ApplicationRecord
  belongs_to :network_taggable, polymorphic: true
  validates_uniqueness_of :network_taggable_id, scope: [:network_taggable_type, :network_taggable_id]
end
