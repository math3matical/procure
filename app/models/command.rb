class Command < ApplicationRecord
  include Visible

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :tags, as: :tag_taggable, dependent: :destroy
  has_many :tag_items, :through => :tags

  has_one :satellite_tag, as: :satellite_taggable, dependent: :destroy
  has_one :provision_tag, as: :provision_taggable, dependent: :destroy
  has_one :network_tag, as: :network_taggable, dependent: :destroy

  validates_uniqueness_of :name, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def self.search(search)
    search ||=""
    search = search.gsub(/[[:space:]]+/, "")
    unless search == ""
      @stuff = Command.joins(:tag_items).where('tag_items.name LIKE ?', "%#{search}%")
#      @stuff2 = Command.joins(:engineers).where('engineers.first_name LIKE :search or engineers.last_name LIKE :search', search: "%#{search}%")
      @stuff3 = Command.joins(:comments).where('comments.body LIKE ?', "%#{search}%")
      @stuff4 = Command.where('name LIKE :search or body LIKE :search', search: "%#{search}%")
      ids = []
      ids = @stuff.ids + @stuff3.ids + @stuff4.ids
      @stuff = Command.where(id: ids)
    else
      Command.all
    end
  end
end
