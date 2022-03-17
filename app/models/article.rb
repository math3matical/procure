class Article < ApplicationRecord
  include Visible

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :tags, as: :tag_taggable, dependent: :destroy
  has_many :tag_items, :through => :tags

  has_one :satellite_tag, as: :satellite_taggable, dependent: :destroy
  has_one :provision_tag, as: :provision_taggable, dependent: :destroy
  has_one :network_tag, as: :network_taggable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def self.search(search)
    search ||=""
    search = search.gsub(/[[:space:]]+/, "")
    unless search == ""
      @stuff = Article.joins(:tag_items).where('tag_items.name LIKE ?', "%#{search}%")
      @stuff2 = Article.joins(:comments).where('comments.body LIKE ?', "%#{search}%")
      @stuff3 = Article.where('title LIKE :search or body LIKE :search', search: "%#{search}%")
      ids = []
      ids = @stuff.ids + @stuff2.ids + @stuff3.ids
      @stuff = Article.where(id: ids)
    else
      Article.all
    end
  end
end
