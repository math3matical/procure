class Tag < ApplicationRecord
  #include Visible
 
  validates_uniqueness_of :tag_item_id, scope: [:tag_taggable_type, :tag_taggable_id]


  belongs_to :tag_taggable, polymorphic: true
  belongs_to :tag_item

end
