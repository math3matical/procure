class TagItem < ApplicationRecord
  #include Visible

  #has_one :tag_group
  has_many :tags, dependent: :destroy
  belongs_to :tag_group

  validates_uniqueness_of :name, scope: :tag_group_id
end
