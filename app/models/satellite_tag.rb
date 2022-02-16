class SatelliteTag < ApplicationRecord
  #include Visible
  
  belongs_to :satellite_taggable, polymorphic: true
  validates_uniqueness_of :satellite_taggable_id, scope: [:satellite_taggable_type, :satellite_taggable_id]
end
