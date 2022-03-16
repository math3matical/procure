class TagGroup < ApplicationRecord
  #include Visible

  validates_uniqueness_of :name

  has_many :tag_items, dependent: :destroy
end
